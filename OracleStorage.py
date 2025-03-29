import oci

class OracleObjectStorage:
    def __init__(self, config_file='~/.oci/config', profile='DEFAULT'):
        """
        Inicializa o cliente para acessar o Oracle Object Storage.
        :param config_file: Caminho do arquivo de configuração OCI.
        :param profile: Perfil de autenticação no arquivo de configuração.
        """
        self.config = oci.config.from_file(config_file, profile)
        self.object_storage_client = oci.object_storage.ObjectStorageClient(self.config)

    def upload_file(self, namespace, bucket_name, file_path, object_name):
        """
        Faz o upload de um arquivo para o Oracle Object Storage.
        :param namespace: Namespace do bucket.
        :param bucket_name: Nome do bucket.
        :param file_path: Caminho do arquivo local.
        :param object_name: Nome do arquivo no bucket.
        """
        with open(file_path, "rb") as file:
            self.object_storage_client.put_object(
                namespace, bucket_name, object_name, file
            )
        print(f"✅ Upload de {object_name} realizado com sucesso!")

    def download_file(self, namespace, bucket_name, object_name, download_path):
        """
        Faz o download de um arquivo do Oracle Object Storage.
        :param namespace: Namespace do bucket.
        :param bucket_name: Nome do bucket.
        :param object_name: Nome do arquivo no bucket.
        :param download_path: Caminho para salvar o arquivo baixado.
        """
        response = self.object_storage_client.get_object(namespace, bucket_name, object_name)
        with open(download_path, "wb") as file:
            for chunk in response.data.raw.stream(1024 * 1024, decode_content=False):
                file.write(chunk)
        print(f"✅ Download de {object_name} realizado com sucesso!")

