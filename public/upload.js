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
      // Display the success message
      uploadMessageElement.textContent = 'Arquivo enviado com sucesso!';
      uploadMessageElement.style.color = 'green';

      // Clear the file input to allow for another upload
      uploadForm.reset();
    })
    .catch(error => {
      console.error('Error uploading file:', error);
      // Display the error message
      uploadMessageElement.textContent = 'Erro ao enviar o arquivo. Por favor, tente novamente.';
      uploadMessageElement.style.color = 'red';
    });
  });
});