from PyQt6.QtGui import QIcon
from ui_py.login_win import LoginForm
from database.db import *
from PyQt6.QtWidgets import QMainWindow, QWidget, QApplication, QLineEdit
from win.admin_win import AdminWin
from win.client_win import ClientWin
from win.manager_win import ManagerWin

class LoginWin(QMainWindow, LoginForm):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setupUi(self)
        self.setWindowIcon(QIcon("assets/icon.ico"))
        self.setWindowTitle("Авторизация")
        self.pushButton.clicked.connect(self.log_in)
        self.pushButton_2.clicked.connect(self.guest_win)
        self.lineEdit_2.setEchoMode(QLineEdit.EchoMode.Password)

    def log_in(self):
        try:
            login = self.lineEdit.text()
            passw = self.lineEdit_2.text()
            sql = """SELECT u.name, u.surname, u.last_name, r.name as role_name FROM users u
                    JOIN roles r ON r.role_id = u.role_id WHERE login = %s AND password_hash = %s"""
            res = select_query(sql, (login, passw))
            print(res)
            user = res[0]
            full_name = f"{user['name']} {user['surname']} {user['last_name']}"
            role = user['role_name']
            print(full_name, role)

            if role == "Администратор":
                self.new_win = AdminWin(full_name)
            elif role == "Менеджер":
                self.new_win = ManagerWin(full_name)
            else:
                self.new_win = ClientWin(full_name)
            self.new_win.show()
            self.close()
        except Exception as e:
            print("log_in: ", e)

    def guest_win(self):
        try:
            self.guest_win = ClientWin()
            self.guest_win.show()
            self.close()
        except Exception as e:
            print("guest_win: ", e)

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    win = LoginWin()
    win.show()
    sys.exit(app.exec())