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
          <div id="dados-paciente">
            <h2>Dados do paciente</h2>
            <dl>
              <dt><strong>Nome:</strong></dt>
              <dd>${data.name}</dd>
              <dt><strong>Email:</strong><dt> 
              <dd>${data.email}</dd>
              <dt><strong>Data de nascimento:</strong></dt>
              <dd>${data.birthdate}</dd>
              <dt><strong>Endereço:</strong></dt>
              <dd>${data.address}</dd>
              <dt><strong>Cidade:</strong></dt>
              <dd>${data.city}</dd>
              <dt><strong>Estado:</strong></dt>
              <dd>${data.state}</dd>
            </dl>
          </div>
          <h3>Detalhes dos exames</h3>
          <dl>
            <dt><strong>Token do exame:</strong></dt>
            <dd>${data.exam_token}</dd>
            <dt><strong>Data do exame:</strong></dt>
            <dd>${data.exam_date}</dd>
            <dt><strong>Médico responsável:</strong></dt>
            <dd>${data.doctor.doctor_name}</dd>
            <dt><strong>CRM:</strong></dt>
            <dd>${data.doctor.doctor_registration}, ${data.doctor.doctor_state}</dd>
          </dl>
          <h4>Resultados</h4>
          <dl>
            <!-- Exam results will be appended here -->
          </dl>
        `;


        data.results.forEach(result => {
          htmlString += `
            <dt><strong>${result.exam_type}:</strong></dt>
            <dd>${result.exam_results}</dd>
            <dt><strong>Intervalo de referência:</strong></dt>
            <dd>${result.exam_ranges}</dd>
          `;
        });

        examDetailsElement.innerHTML = htmlString;
      })
      .catch(error => {
        console.error('Error fetching exam data:', error);
        examDetailsElement.innerHTML = '<p>Error fetching exam data</p>';
      });
  });
});
