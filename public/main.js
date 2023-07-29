document.addEventListener('DOMContentLoaded', () => {
  const examForm = document.getElementById('examForm');
  const examDetailsElement = document.getElementById('examDetails'); 

  examForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const tokenValue = document.getElementById('token').value;

    fetch(`/api/tests/${tokenValue}`)
      .then(response => response.json())
      .then(data => {

        let htmlString = `
          <p></p>
          <div>
            <div class="card" style="width: 18rem;">
              <div class="card-header">
                Dados do Paciente
              </div>
              <ul class="list-group list-group-flush">
                <li class="list-group-item">Nome: ${data.name}</li>
                <li class="list-group-item">Email: ${data.email}</li>
                <li class="list-group-item">Data de nascimento: ${data.birthdate}</li>
                <li class="list-group-item">Endereço: ${data.address}</li>
                <li class="list-group-item">Cidade: ${data.city}</li>
                <li class="list-group-item">Estado: ${data.state}</li>
              </ul>
            </div>
            <p></p>
            <div class="card" style="width: 18rem;">
              <div class="card-header">
                Detalhes do exame
              </div>
              <ul class="list-group list-group-flush">
                <li class="list-group-item">Token do exame: ${data.exam_token}</li>
                <li class="list-group-item">Data: ${data.exam_date}</li>
                <li class="list-group-item">Médico responspavel: ${data.doctor.doctor_name}</li>
                <li class="list-group-item">CRM: ${data.doctor.doctor_registration}, ${data.doctor.doctor_state_registration} </li>
              </ul>
            </div>
            <p></p>
            <div class="card" style="width: 18rem;">
              <div class="card-header">
                Resultados
              </div>
              <ul class="list-group list-group-flush">
                <!-- Exam results will be appended here -->
          `;


        data.results.forEach(result => {
          htmlString += `
            <li class="list-group-item"><strong>${result.exam_type}</strong></li>
            <li class="list-group-item">Resultado: ${result.exam_results}</li>
            <li class="list-group-item">Intervalo de referência: ${result.exam_ranges}</li>
          `;
        });

        htmlString += `
            </ul>
          </div>
        </div>
        `

        examDetailsElement.innerHTML = htmlString;
      })
      .catch(error => {
        console.error('Error fetching exam data:', error);
        examDetailsElement.innerHTML = '<p>Error fetching exam data</p>';
      });
  });
});
