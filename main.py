# Configurações do ADB (os valores devem ser obtidos no Console Oracle)
dsn = "XDYKI216MJI01EWO"
user = "ADMIN"
password = "5PMJwWJ&K&MU8#rKYE7"

# Criar a classe e conectar ao ADB
adb = OracleAutonomousDatabase(dsn, user, password)
adb.connect()

# Exemplo de consulta
query = "SELECT * FROM tabela_exemplo WHERE coluna = :param"
params = {'param': 'valor'}
result = adb.query(query, params)
print(result)

# Fechar a conexão
adb.close()
