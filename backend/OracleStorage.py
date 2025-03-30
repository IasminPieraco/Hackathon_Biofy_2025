import oci
import os
from datetime import datetime

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

    def download_files(self, namespace, bucket_name, object_names=None, download_path="downloads"):
   
        # Criar diretório se não existe
        os.makedirs(download_path, exist_ok=True)
        
        # Obter lista de objetos se não fornecida
        if object_names is None:
            list_objects_response = self.object_storage_client.list_objects(
                namespace, 
                bucket_name
            )
            object_names = [obj.name for obj in list_objects_response.data.objects]
        
        # Lista para armazenar informações dos arquivos
        downloaded_files = []
        
        for object_name in object_names:
            try:
                # Baixar arquivo
                response = self.object_storage_client.get_object(
                    namespace, 
                    bucket_name, 
                    object_name
                )
                
                # Criar caminho completo para salvar
                full_path = os.path.join(download_path, object_name)
                
                # Baixar arquivo em chunks
                with open(full_path, "wb") as file:
                    for chunk in response.data.raw.stream(1024 * 1024, decode_content=False):
                        file.write(chunk)
                
                # Converter arquivo para base64
                with open(full_path, "rb") as file:
                    base64_content = base64.b64encode(file.read()).decode('utf-8')
                
                # Adicionar informações ao resultado
                downloaded_files.append({
                    'nome': object_name,
                    'data_criacao': datetime.now().strftime('%d/%m/%Y'),
                    'base64': base64_content
                })
                
                print(f"✅ Download de {object_name} realizado com sucesso!")
                
            except Exception as e:
                print(f"❌ Erro ao baixar {object_name}: {str(e)}")
    
        return downloaded_files

