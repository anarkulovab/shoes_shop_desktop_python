import random

from PyQt6.QtWidgets import QDialog, QApplication, QDialogButtonBox, QMessageBox

from database.db import update_query, select_query
from ui_py.order_dialog import OrderDialog

class OrderForm(QDialog, OrderDialog):
    def __init__(self, order=None, parent=None):
        super().__init__(parent)
        self.setupUi(self)
        self.order = None
        self.buttonBox.button(QDialogButtonBox.StandardButton.Ok).setText("Сохранить")
        self.buttonBox.button(QDialogButtonBox.StandardButton.Cancel).setText("Отмена")
        self.set_combo_values()
        if order:
            self.order = order
            delete_btn = self.buttonBox.addButton("Удалить", QDialogButtonBox.ButtonRole.DestructiveRole)
            delete_btn.clicked.connect(self.delete_order)
            self.set_order_values(order)
        self.lineEdit.setEnabled(False)
        self.buttonBox.accepted.connect(self.save_order)

    def set_combo_values(self):
        try:
            statuses = select_query("SELECT * FROM statuses;")
            points = select_query("SELECT * FROM pick_up_points;")
            self.status_box.addItems([status['name'] for status in statuses])
            self.comboBox_2.addItems(point['address'] for point in points)
        except Exception as e:
            print("set_combo_values: ", e)

    def delete_order(self):
        try:
            order_id = self.lineEdit.text()
            update_query("DELETE FROM order_products WHERE order_id = %s", (order_id,))
            update_query("DELETE FROM orders WHERE order_id = %s", (order_id,))
            QMessageBox.question(self, "Удаление товара", "Вы уверены, что хотите удалить заказ?")
            QMessageBox.information(self, "Успех", "Заказ успешно удален")
            self.accept()
        except Exception as e:
            print("delete_order: ", e)

    def set_order_values(self, order):
        try:
            order_id = order['order_id']
            status = order['status_name']
            point = order['point_name']
            order_date = order['order_date']
            delivery_date = order['delivery_date']

            self.lineEdit.setText(f"{order_id}")
            self.status_box.setCurrentText(status)
            self.comboBox_2.setCurrentText(point)
            self.dateEdit.setDate(order_date)
            self.dateEdit_2.setDate(delivery_date)
        except Exception as e:
            print("set_order_values: ", e)

    def save_order(self):
        try:
            status = self.status_box.currentText()
            point = self.comboBox_2.currentText()
            order_date = self.dateEdit.date()
            delivery_date = self.dateEdit.date()

            status_id = select_query("SELECT status_id FROM statuses WHERE name=%s", status)[0]['status_id']
            point_id = select_query("SELECT point_id FROM pick_up_points WHERE address = %s", point)[0]['point_id']

            if delivery_date < order_date:
                QMessageBox.warning(self, "Ошибка", "Дата выдачи не может быть раньше даты заказа")
                return

            delivery_date = delivery_date.toString('yyyy-MM-dd')
            order_date = order_date.toString('yyyy-MM-dd')
            if self.order:
                order_id = self.lineEdit.text()
                sql = """UPDATE orders SET status_id = %s, point_address_id = %s, 
                       order_date = %s, delivery_date = %s WHERE order_id = %s"""
                if update_query(sql, (status_id, point_id, order_date, delivery_date, order_id)):
                    QMessageBox.information(self, "Успешно", "Данные успешно сохранены")
            else:
                sql = """INSERT INTO orders(order_date, delivery_date, point_address_id, client_id, code_to_take, status_id)
                        VALUES (%s, %s, %s, %s, %s, %s)"""
                code_to_take = random.randint(100, 999)
                if update_query(sql, (order_date, delivery_date, point_id, 1, code_to_take, status_id)):
                    QMessageBox.information(self, "Успешно", "Данные успешно сохранены")
        except Exception as e:
            print("save_order: ", e)

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    dialog = OrderForm()
    dialog.show()
    sys.exit(app.exec())