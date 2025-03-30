import oci
import base64

class OracleVisionAI:
    def __init__(self, config_path, profile, model_id, compartment_id):
        """
        Inicializa o cliente AI Vision da Oracle.
        :param config_path: Caminho para o arquivo de configuração OCI.
        :param profile: Nome do perfil dentro do arquivo de configuração.
        :param model_id: OCID do modelo AI Vision treinado.
        :param compartment_id: OCID do compartimento da Oracle Cloud.
        """
        self.config = oci.config.from_file(config_path, profile_name=profile)
        self.client = oci.ai_vision.AIServiceVisionClient(self.config)
        self.model_id = model_id
        self.compartment_id = compartment_id

    def classify_image(self, image_path):
        with open(image_path, "rb") as image_file:
            encoded_string = base64.b64encode(image_file.read()).decode("utf-8")

        # Construção correta do objeto de análise
        analyze_image_details = oci.ai_vision.models.AnalyzeImageDetails(
            features=[
                oci.ai_vision.models.ImageClassificationFeature(
                    feature_type="IMAGE_CLASSIFICATION",
                    max_results=50,
                    model_id=self.model_id
                )
            ],
            image=oci.ai_vision.models.InlineImageDetails(
                source="INLINE",
                data=encoded_string
            ),
            compartment_id=self.compartment_id
        )

        # Chamada correta do método analyze_image
        analyze_image_response = self.client.analyze_image(analyze_image_details)

        # Retornando corretamente os rótulos detectados
        return analyze_image_response.data.labels if analyze_image_response.data else []
