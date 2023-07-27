document.addEventListener('DOMContentLoaded', () => {
  const uploadForm = document.getElementById('uploadForm');
  const uploadMessageElement = document.getElementById('uploadMessage');

  uploadForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const formData = new FormData(uploadForm);

    fetch('/upload', {
      method: 'POST',
      body: formData,
    })
    .then(response => response.json())
    .then(data => {
      uploadMessageElement.textContent = 'Arquivo enviado com sucesso!';
      uploadMessageElement.style.color = 'green';

      uploadForm.reset();
    })
    .catch(error => {
      console.error('Error uploading file:', error);
      uploadMessageElement.textContent = 'Erro ao enviar o arquivo. Por favor, tente novamente.';
      uploadMessageElement.style.color = 'red';
    });
  });
});