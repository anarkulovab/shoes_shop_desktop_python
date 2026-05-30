from PyQt6.QtCore import Qt
from PyQt6.QtGui import QIcon, QPixmap
from PyQt6.QtWidgets import QMainWindow, QWidget, QApplication
from ui_py.main_win import MainWin
from database.db import *
from ui_py.product_card import ProductCard


class ClientWin(QMainWindow, MainWin):
    def __init__(self, full_name=None, parent=None):
        super().__init__(parent)
        self.setupUi(self)
        self.setWindowIcon(QIcon("../assets/icon.ico"))
        self.setWindowTitle("Обувной магазин")
        self.tabWidget.setCurrentIndex(0)
        self.pushButton_2.clicked.connect(self.log_out)
        pixmap = QPixmap("../assets/icon.png").scaled(150, 80, Qt.AspectRatioMode.KeepAspectRatio)
        if full_name:
            self.label.setText(f"Добро пожаловать, {full_name}")
            self.label_2.setText("Клиент")
        else:
            self.label.setText(f"Добро пожаловать, гость")
            self.label_2.setText("Гость")
        self.label_3.setPixmap(pixmap)
        self.get_products()
        self.pushButton.hide()
        self.pushButton_3.hide()
        self.pushButton_4.hide()
        self.tabWidget.tabBar().hide()
        self.frame_2.hide()


    def log_out(self):
        from main import LoginWin
        self.log_win = LoginWin()
        self.log_win.show()
        self.close()

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
                self.verticalLayout_5.addWidget(card_widget)
        except Exception as e:
            print("load_products: ", e)

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    win = ClientWin("Никифорова Весения Николаевна")
    win.show()
    sys.exit(app.exec())