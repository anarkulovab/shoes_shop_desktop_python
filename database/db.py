import os
import sys
import pymysql as psql
from pymysql.cursors import DictCursor

try:
    conn = psql.connect(
        host='localhost',
        user='root',
        password='root',
        database='shoes_shop',
        cursorclass=psql.cursors.DictCursor
    )
    print("BD connect ok")

except Exception as e:
    print("BD NOT OK", e)


def update_query(sql, params=None):
    """Функция для запросов удаления, редактирования и вставки данных"""
    try:
        cursor = conn.cursor()
        if params:
            cursor.execute(sql, params)
        else:
            cursor.execute(sql)
        conn.commit()
        cursor.close()
        return True
    except Exception as e:
        print("update_query:", e)

def select_query(sql, params=None):
    try:
        cursor = conn.cursor()
        if params:
            cursor.execute(sql, params)
        else:
            cursor.execute(sql)
        res = cursor.fetchall()
        cursor.close()
        return res
    except Exception as e:
        print("select_query: ", e)


def resource_path(relative_path):
    """Получить абсолютный путь к ресурсу"""
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base_path, relative_path)
