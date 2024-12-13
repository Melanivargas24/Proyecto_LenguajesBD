
function Toggle2(button){
    // Obtener el elemento i dentro del botón
    var icon = button.querySelector('i');

    if (icon.style.color === "red") {
        icon.style.color = "black";
    } else {
        icon.style.color = "red";
    }
}

function addCard(formulario) {
    var valor = formulario.elements[0].value;
    var url = '/carrito/agregar';
    url = url + '/' + valor;
    $("#resultsBlock").load(url);
}

function toggleAndAddCard(button) {
    var isAuthenticated;

    if (!isAuthenticated) {
        window.alert("Debe iniciar sesión para agregar elementos al carrito.");
        return;
    }  
    Toggle2(button);
    addCard(button.form);
}

