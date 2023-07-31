document.addEventListener('DOMContentLoaded', () => {
  const examForm = document.getElementById('examForm');
  const patientDetailsElement = document.getElementById('pacienteDetails');
  const doctorDetailsElement = document.getElementById('doctorDetails');
  const exameDetailsElement = document.getElementById('exameDetails');


  examForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const tokenValue = document.getElementById('token').value;

    fetch(`/api/tests/${tokenValue}`)
      .then(response => response.json())
      .then(data => {

        let htmlString1 = `
                <li class="list-group-item">Nome: ${data.name}</li>
                <li class="list-group-item">Email: ${data.email}</li>
                <li class="list-group-item">Data de nascimento: ${data.birthdate}</li>
                <li class="list-group-item">Endereço: ${data.address}</li>
                <li class="list-group-item">Cidade: ${data.city}</li>
                <li class="list-group-item">Estado: ${data.state}</li>
              `;
        let htmlString2 = `
                <li class="list-group-item">Token do exame: ${data.exam_token}</li>
                <li class="list-group-item">Data: ${data.exam_date}</li>
                <li class="list-group-item">Médico responspavel: ${data.doctor.doctor_name}</li>
                <li class="list-group-item">CRM: ${data.doctor.doctor_registration}, ${data.doctor.doctor_state_registration} </li>
        `;


        let htmlString3 = ``;
        data.results.forEach(result => {
          htmlString3 += `
            <li class="list-group-item"><strong>${result.exam_type}</strong></li>
            <li class="list-group-item">Resultado: ${result.exam_results}</li>
            <li class="list-group-item">Intervalo de referência: ${result.exam_ranges}</li>
          `;
        });

        patientDetailsElement.innerHTML = htmlString1;
        doctorDetailsElement.innerHTML = htmlString2;
        exameDetailsElement.innerHTML = htmlString3;
      })
      .catch(error => {
        console.error('Error fetching exam data:', error);
        examDetailsElement.innerHTML = '<p>Error fetching exam data</p>';
      });
  });
});
