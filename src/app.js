// app.js

const express = require('express');
const requestIp = require('request-ip');
const fs = require('fs');
const AWS = require('aws-sdk');

const app = express();

// Middleware para obter o IP do cliente
app.use(requestIp.mw());

// Rota principal
app.get('/', (req, res) => {
  const clientIp = req.clientIp;
  
  // Obtém a data atual no formato yyyy-MM-ddTHH:mm:ss.fffZ
  const timestampfull = new Date().toISOString();
  const fileName = `${timestampfull.replace(/[-T:.]/g, ' ').replace(/[Z]/g, '')}.txt`;
  const timestamp = timestampfull.replace(/[T]/g, ' ').replace(/[Z]/g, '');

  // Cria um arquivo com timestamp e IP do cliente separados por tab
  const fileContent = `${timestamp}\t${clientIp}`;
  fs.writeFileSync(fileName, fileContent);

  // Envia o arquivo para o S3
  uploadToS3(fileName);

  res.send(`Hello World!!! Ip: ${clientIp}`);
});

// Configuração da porta
const port = 3000;
app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});

// Função para enviar o arquivo para o S3
function uploadToS3(fileName) {
  const s3 = new AWS.S3();

  const params = {
    Bucket: 'my-log-bucket-lohan-2024',
    Key: fileName,
    Body: fs.createReadStream(fileName),
  };

  s3.upload(params, (err, data) => {
    if (err) {
      console.error('Erro ao fazer upload para o S3:', err);
    } else {
      console.log('Arquivo enviado para o S3:', data.Location);

      // Remover o arquivo local após o upload
      fs.unlinkSync(fileName);
    }
  });
}
