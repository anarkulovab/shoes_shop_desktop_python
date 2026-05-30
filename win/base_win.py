from PyQt6.QtCore import Qt
from PyQt6.QtGui import QIcon, QPixmap
from PyQt6.QtWidgets import QMainWindow, QWidget, QApplication

from dialogs.order_form import OrderForm
from ui_py.main_win import MainWin
from database.db import *
from ui_py.order_card import OrderCard
from ui_py.product_card import ProductCard
from dialogs.product_form import ProductForm


class BaseWin(QMainWindow, MainWin):
    def __init__(self, full_name, parent=None):
        super().__init__(parent)
        self.setupUi(self)
        self.tabWidget.setCurrentIndex(0)

        self.setWindowIcon(QIcon("../assets/icon.ico"))
        pixmap = QPixmap(resource_path("assets/icon.png")).scaled(150, 80, Qt.AspectRatioMode.KeepAspectRatio)
        self.label.setText(f"Добро пожаловать, {full_name}")
        self.label_3.setPixmap(pixmap)

        self.pushButton_2.clicked.connect(self.log_out)
        self.get_products()
        self.load_suppliers()
        self.load_orders()
        self.comboBox.addItems(["По умолчанию", "По убыванию", "По возрастанию"])
        self.lineEdit.textChanged.connect(self.filter_products)
        self.comboBox_2.currentTextChanged.connect(self.filter_products)
        self.comboBox.currentTextChanged.connect(self.filter_products)
        self.pushButton.clicked.connect(self.product_form)
        self.pushButton_3.clicked.connect(lambda x: self.tabWidget.setCurrentIndex(1))
        self.pushButton_4.clicked.connect(self.order_form)

    def log_out(self):
        try:
            from main import LoginWin
            self.log_win = LoginWin()
            self.log_win.show()
            self.close()
        except Exception as e:
            print("log out: ", e)

    def get_products(self):
        try:
            sql = """SELECT p.product_id, c.name as category_name, p.name, p.description, m.name, s.name, 
                                p.price, p.discount, p.measure_type, p.quantity, p.pic FROM products p
                                JOIN manufactures m ON p.manufacturer_id = m.manufacture_id
                                JOIN categories c ON p.category_id = c.category_id
                                JOIN suppliers s ON p.supplier_id = s.supplier_id
                                ORDER BY p.product_id ASC"""
            self.products = select_query(sql)
            self.load_products(self.products)
        except Exception as e:
            print("get_products: ", e)

    def load_products(self, products):
        try:
            while self.verticalLayout_5.count():
                wid = self.verticalLayout_5.takeAt(0).widget()
                if wid:
                    wid.deleteLater()
            for product in products:
                category_name = product['category_name']
                name = product['name']
                description = product['description']
                manufacturer = product['m.name']
                supplier = product['s.name']
                price = product['price']
                discount = product['discount']
                measure_type = product['measure_type']
                quantity = product['quantity']
                pic = product['pic']
                if pic:
                    pic = f"assets/{pic}"
                else:
                    pic = f"assets/picture.png"
                pixmap = QPixmap(resource_path(pic)).scaled(300, 200, Qt.AspectRatioMode.KeepAspectRatio)

                card_widget = QWidget()
                card = ProductCard()
                card.setupUi(card_widget)
                card.category_label.setText(category_name)
                card.name_label.setText(name)
                card.description_label.setText(description)
                card.manufacturer_label.setText(manufacturer)
                card.supplier_label.setText(supplier)
                card.measure_type_label.setText(measure_type)

                card.quantity_label.setText(f"{quantity}")
                if quantity == 0:
                    card.frame.setStyleSheet("background-color:#c1e8ff;")

                if discount:
                    final_price = price - (price * discount / 100)
                    card.discount_label.setText(f"   {discount}%    ")
                    if discount > 15:
                        card.discount_label.setStyleSheet("background-color:#2E8B57;")
                else:
                    final_price = price
                card.price_label.setText(f"""
                            <span style="text-decoration:line-through; color: red;font-size:17px;"> {price:.2f} руб.</span>
                            <span style="font-size:18px;"> {final_price:.2f} руб.""")
                card.pic.setPixmap(pixmap)

                card_widget.mousePressEvent = lambda event, p=product: self.product_form(p)
                self.verticalLayout_5.addWidget(card_widget)
        except Exception as e:
            print("load_products: ", e)

    def load_suppliers(self):
        try:
            sql = """SELECT name FROM suppliers;"""
            res = select_query(sql)
            self.suppliers = ["Все поставщики"] + [item['name'] for item in res]
            self.comboBox_2.addItems(self.suppliers)
        except Exception as e:
            print("load_suppliers: ", e)

    def filter_products(self):
        try:
            search = self.lineEdit.text()
            supplier = self.comboBox_2.currentText()
            sort_type = self.comboBox.currentText()
            products = self.products.copy()

            if search:
                filtered_products = []
                for product in products:
                    for value in product.values():
                        if search in str(value).lower():
                            filtered_products.append(product)
                            break
                products = filtered_products

            if supplier:
                filtered_products = []
                if supplier != "Все поставщики":
                    for product in products:
                        if supplier == product['s.name']:
                            filtered_products.append(product)
                    products = filtered_products

            if sort_type:
                if sort_type == "По возрастанию":
                    products.sort(key=lambda p: p['quantity'])
                elif sort_type == "По убыванию":
                    products.sort(key=lambda p: p['quantity'], reverse=True)

            self.load_products(products)
        except Exception as e:
            print("filter: ", e)

    def product_form(self, product=None):
        try:
            self.form = ProductForm(product)
            self.form.exec()
            if self.form.accepted:
                self.get_products()
        except Exception as e:
            print("add_product: ", e)


    def load_orders(self):
        try:
            while self.verticalLayout_7.count():
                wid = self.verticalLayout_7.takeAt(0).widget()
                if wid:
                    wid.deleteLater()
            self.orders = select_query("SELECT o.order_id, s.name as status_name, p.address as point_name, o.order_date, o.delivery_date "
                                       "FROM orders o "
                                       "JOIN statuses s ON s.status_id = o.status_id "
                                       "JOIN pick_up_points p ON p.point_id = o.point_address_id "
                                       "ORDER BY o.order_id ASC;")
            for order in self.orders:
                order_id = order['order_id']
                status = order['status_name']
                point = order['point_name']
                order_date = order['order_date']
                delivery_date = order['delivery_date']

                card_widget = QWidget()
                card = OrderCard()
                card.setupUi(card_widget)
                card.label.setText(f"{delivery_date}")
                card.label_2.setText(f"{order_id}")
                card.label_3.setText(status)
                card.label_4.setText(point)
                card.label_5.setText(f"{order_date}")

                self.verticalLayout_7.addWidget(card_widget)

                card_widget.mousePressEvent = lambda event, o=order:self.order_form(o)
        except Exception as e:
            print("load_orders: ", e)

    def order_form(self, order):
        try:
            dialog = OrderForm(order)
            dialog.exec()
            if dialog.accepted:
                self.load_orders()
        except Exception as e:
            print("order_form: ", e)

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    win = AdminWin("Никифорова Весения Николаевна")
    win.show()
    sys.exit(app.exec())