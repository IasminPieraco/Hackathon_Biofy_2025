import cx_Oracle

class OracleAutonomousDatabase:
    def __init__(self, dsn, user, password, port=1521):
        """
        Inicializa a conexão com o Oracle Autonomous Database.
        :param dsn: Data Source Name (DSN), como o hostname do banco de dados.
        :param user: Nome de usuário para conexão com o banco.
        :param password: Senha para o banco de dados.
        :param port: Porta para conexão (padrão é 1521).
        """
        self.dsn = dsn
        self.user = user
        self.password = password
        self.port = port
        self.connection = None
        self.cursor = None

    def connect(self):
        """
        Conecta-se ao banco de dados.
        """
        try:
            self.connection = cx_Oracle.connect(
                self.user, self.password, self.dsn, port=self.port
            )
            self.cursor = self.connection.cursor()
            print("✅ Conexão bem-sucedida ao Oracle Autonomous Database!")
        except cx_Oracle.Error as e:
            print(f"Erro ao conectar ao Oracle Autonomous Database: {e}")

    def query(self, query, params=None):
        """
        Executa uma consulta SQL no banco de dados.
        :param query: A query SQL a ser executada.
        :param params: Parâmetros para a consulta (opcional).
        :return: Resultados da consulta.
        """
        try:
            self.cursor.execute(query, params or [])
            result = self.cursor.fetchall()
            return result
        except cx_Oracle.Error as e:
            print(f"Erro na consulta: {e}")
            return None

    def close(self):
        """
        Fecha a conexão com o banco de dados.
        """
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        print("✅ Conexão com o banco de dados fechada.")

    def insert(self, table, data):
        """
        Insere dados em uma tabela do banco de dados.
        :param table: Nome da tabela onde os dados serão inseridos.
        :param data: Dicionário com os dados a serem inseridos.
        """
        columns = ', '.join(data.keys())
        placeholders = ', '.join([':' + key for key in data.keys()])
        sql = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"
        try:
            self.cursor.execute(sql, data)
            self.connection.commit()
            print("✅ Dados inseridos com sucesso!")
        except cx_Oracle.Error as e:
            print(f"Erro ao inserir dados: {e}")
            self.connection.rollback()
        finally:
            self.close()
    def update(self, table, data, condition):
        """
        Atualiza dados em uma tabela do banco de dados.
        :param table: Nome da tabela onde os dados serão atualizados.
        :param
        data: Dicionário com os dados a serem atualizados.
        :param condition: Condição para a atualização (ex: "id = :id").
        """
        set_clause = ', '.join([f"{key} = :{key}" for key in data.keys()])
        sql = f"UPDATE {table} SET {set_clause} WHERE {condition}"
        try:
            self.cursor.execute(sql, data)
            self.connection.commit()
            print("✅ Dados atualizados com sucesso!")
        except cx_Oracle.Error as e:
            print(f"Erro ao atualizar dados: {e}")
            self.connection.rollback()
        finally:
            self.close()
    def delete(self, table, condition):
        """
        Deleta dados de uma tabela do banco de dados.
        :param table: Nome da tabela de onde os dados serão deletados.
        :param condition: Condição para a deleção (ex: "id = :id").
        """
        sql = f"DELETE FROM {table} WHERE {condition}"
        try:
            self.cursor.execute(sql)
            self.connection.commit()
            print("✅ Dados deletados com sucesso!")
        except cx_Oracle.Error as e:
            print(f"Erro ao deletar dados: {e}")
            self.connection.rollback()
        finally:
            self.close()

