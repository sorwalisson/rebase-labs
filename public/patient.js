document.addEventListener('DOMContentLoaded', () => {
  const patientForm = document.getElementById('patientForm');
  const dadosPacientElement = document.getElementById('dadospaciente'); 
  const dropElement = document.getElementById('droppaciente');
  const examesElement = document.getElementById('exames');

  patientForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const cpfValue = document.getElementById('cpf').value;

    fetch(`/api/patients/${cpfValue}`)
      .then(response => response.json())
      .then(data => {

        let htmlString = `
                <li class="list-group-item">Nome: ${data.name}</li>
                <li class="list-group-item">Email: ${data.email}</li>
                <li class="list-group-item">Data de nascimento: ${data.birthdate}</li>
                <li class="list-group-item">Endereço: ${data.address}</li>
                <li class="list-group-item">Cidade: ${data.city}</li>
                <li class="list-group-item">Estado: ${data.state}</li>
          `;
        dadosPacientElement.innerHTML = htmlString;

        let htmlString2 = ``;

        data.exams.forEach((hash, index) => {
          const keys = Object.keys(hash);
          const lastKey = keys[keys.length - 1];
          
          htmlString2 += `
          <li><a class="dropdown-item" data-exam-index="${index}">${lastKey}</a></li>
        `});

        dropElement.innerHTML = htmlString2;
        activateDropdown();
      })
      .catch(error => {
        console.error('Error fetching exam data:', error);
        examDetailsElement.innerHTML = '<p>Error fetching exam data</p>';
      });
  });
  
  dropdownExamsElement.addEventListener('click', (event) => {
    const selectedExamIndex = event.target.getAttribute('data-exam-index');
    const selectedExam = data.exams[selectedExamIndex];
    displayExamResults(selectedExam);
  });

  function displayExamResults(examResults) {
    let htmlString = '';
    examResults.forEach(result => {
      htmlString += `
        <li class="list-group-item"><strong>${result.exam_type}</strong></li>
        <li class="list-group-item">Resultado: ${result.exam_results}</li>
        <li class="list-group-item">Intervalo de referência: ${result.exam_ranges}</li>
      `;
    });
    examResultsElement.innerHTML = htmlString;
  }
});