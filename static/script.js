async function carregarAventureiros() {
    try {
      const response = await fetch('/aventureiros');
      const aventureiros = await response.json();
      console.log(aventureiros);

    if (!response.ok) {
    throw new Error('Erro ao carregar os aventureiros');
    }

    const container = document.querySelector('#aventureirosContainer');
    container.innerHTML = '';

    aventureiros.forEach(avent => {
    const card = document.createElement('div');
    card.className = 'bg-white rounded-2xl shadow-md p-4 hover:shadow-xl cursor-pointer transition';
    card.onclick = () => mostrarDetalhes(avent);

    const imagePath = `../static/images/${avent.classe}.png`;

    card.innerHTML = `
        <img src="${imagePath}" alt="${avent.nome}" class="w-full h-96 object-cortain rounded-t-2xl mb-4">
        <h2 class="text-xl font-semibold text-gray-800">${avent.nome}</h2>
        <p class="text-gray-500">Classe: ${avent.classe}</p>
    `;
    container.appendChild(card);
    });

    } catch (err) {
      console.error('Erro ao carregar aventureiros:', err);
    }
}

document.addEventListener('DOMContentLoaded', function() {
carregarAventureiros();
});

function mostrarDetalhes(avent) {
  document.getElementById('painelDetalhes').classList.remove('hidden');
  document.getElementById('d_nome').textContent = avent.nome;
  document.getElementById('d_classe').textContent = avent.classe;
  document.getElementById('d_alcance').textContent = avent.alcance;
  document.getElementById('d_descricao').textContent = avent.descricao;
  document.getElementById('d_nivel').textContent = avent.nivel;
  document.getElementById('d_xp').textContent = avent.xp;
  document.getElementById('d_guilda').textContent = avent.guilda;

const imagePath = `../static/images/${avent.classe}.png`;
  document.getElementById('d_imagem').src = imagePath;
  document.getElementById('d_imagem').alt = `Imagem de ${avent.nome}`;
}
