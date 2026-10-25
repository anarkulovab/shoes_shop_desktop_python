from PyQt6.QtCore import Qt
from PyQt6.QtGui import QPixmap, QIntValidator, QDoubleValidator
from PyQt6.QtWidgets import QDialog, QApplication, QDialogButtonBox, QWidget, QFileDialog, QMessageBox
import shutil
from ui_py.product_dialog import ProductsDialog
from database.db import *

class ProductForm(QDialog, ProductsDialog):
    def __init__(self, product=None, parent=None):
        super().__init__(parent)
        self.setupUi(self)
        try:
            self.product = None
            self.buttonBox.button(QDialogButtonBox.StandardButton.Ok).setText("Сохранить")
            self.buttonBox.button(QDialogButtonBox.StandardButton.Cancel).setText("Отмена")
            self.set_combo_values()
            self.original_pic = None
            if product:
                self.product = product
                delete_btn = self.buttonBox.addButton("Удалить", QDialogButtonBox.ButtonRole.DestructiveRole)
                delete_btn.clicked.connect(self.delete_product)
                self.set_product_values(product)

            self.buttonBox.accepted.connect(self.save_product)
            self.label_2.mousePressEvent = self.select_photo
            self.id_edit.setEnabled(False)
            self.lineEdit.setValidator(QDoubleValidator(0.0, 9999999.0, 2))
            self.lineEdit_4.setValidator(QIntValidator(0, 999999))
        except Exception as e:
            print("__init__ ", e)

    def set_combo_values(self):
        try:
            suppliers = select_query("""SELECT * FROM suppliers""")
            manufactures = select_query("""SELECT * FROM manufactures""")
            categories = select_query("""SELECT * FROM categories""")

            self.comboBox.addItems([category['name'] for category in categories])
            self.comboBox_2.addItems([supplier['name'] for supplier in suppliers])
            self.comboBox_3.addItems([manufacture['name'] for manufacture in manufactures])
        except Exception as e:
            print("set_combo_values: ", e)

    def set_product_values(self, product):
        try:
            product_id = product['product_id']
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

            self.comboBox.setCurrentText(category_name)
            self.comboBox_2.setCurrentText(supplier)
            self.comboBox_3.setCurrentText(manufacturer)
            self.id_edit.setText(f"{product_id}")
            self.name_edit.setText(name)
            self.description_edit.setPlainText(description)
            self.lineEdit.setText(f"{price}")
            self.lineEdit_2.setText(f"{discount}")
            self.lineEdit_3.setText(f"{measure_type}")
            self.lineEdit_4.setText(f"{quantity}")
            self.original_pic = pic
            if pic:
                pic = f"assets/{pic}"
            else:
                pic = f"assets/picture.png"
            pixmap = QPixmap(resource_path(pic)).scaled(300, 200, Qt.AspectRatioMode.KeepAspectRatio)
            self.label_2.setPixmap(pixmap)
        except Exception as e:
            print("set_product_values: ", e)

    def delete_product(self):
        try:
            product_id = self.id_edit.text()
            sql = "DELETE FROM products WHERE product_id = %s AND product_id NOT IN (SELECT product_id FROM order_products)"
            update_query(sql, product_id)
            QMessageBox.question(self, "Удаление", "Вы точно хотите удалить товар?")
            QMessageBox.information(self, "Успех", "Товар успешно удален")
            self.accept()
        except Exception as e:
            print("delete_product: ", e)

    def save_product(self):
        try:
            category_name = self.comboBox.currentText()
            supplier = self.comboBox_2.currentText()
            manufacturer_name = self.comboBox_3.currentText()
            product_id = self.id_edit.text()
            name = self.name_edit.text()
            description = self.description_edit.toPlainText()
            price = self.lineEdit.text()
            discount = self.lineEdit_2.text()
            measure_type = self.lineEdit_3.text()
            quantity = self.lineEdit_4.text()

            if not self.validate():
                return
            category_id = select_query("SELECT category_id FROM categories WHERE name = %s", category_name)[0]['category_id']
            manufacturer_id = select_query("SELECT manufacture_id FROM manufactures WHERE name = %s", manufacturer_name)[0]['manufacture_id']
            supplier_id = select_query("SELECT supplier_id FROM suppliers WHERE name = %s", supplier)[0]['supplier_id']

            if not self.original_pic:
                self.original_pic = "picture.png"

            if self.product:
                sql = """UPDATE products
                        SET category_id = %s, supplier_id = %s, manufacturer_id = %s, name = %s, 
                        measure_type = %s, price = %s, discount = %s, quantity = %s, 
                        description = %s, pic = %s
                        WHERE product_id = %s"""
                update_query(sql, (category_id, supplier_id, manufacturer_id, name, measure_type, price,
                                   discount, quantity, description, self.original_pic, product_id))
            else:
                sql = ("INSERT INTO products(article, category_id, supplier_id, manufacturer_id, name, measure_type, "
                       "price, discount, quantity, description, pic)"
                       "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
                update_query(sql, ("A123", category_id, supplier_id, manufacturer_id, name, measure_type, price,
                                   discount, quantity, description, self.original_pic))
            QMessageBox.information(self, "Успех", "Данные успешно сохранены")
        except Exception as e:
            print("save_product: ", e)

    def select_photo(self, event):
        try:
            file_path, _  = QFileDialog.getOpenFileName(self, "Выберите изображение", "", "Images (*.png *jpg *.jpeg)")
            if file_path:
                file_name = os.path.basename(file_path)
                shutil.copy(file_path, resource_path(f"assets/{file_name}"))
                self.original_pic = file_name
                pixmap = QPixmap(file_path).scaled(300, 200, Qt.AspectRatioMode.KeepAspectRatio)
                self.label_2.setPixmap(pixmap)
        except Exception as e:
            print("select_photo: ", e)

    def validate(self):
        if not self.name_edit.text().strip():
            QMessageBox.warning(self, "Ошибка", "Введите название")
            return False
        return True

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    dialog = ProductForm()
    dialog.show()
    sys.exit(app.exec())