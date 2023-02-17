function tax (){
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener("keyup", () => {
    const price = itemPrice.value;
    const taxPrice = parseInt(price / 10)
    const addTaxPrice = document.getElementById("add-tax-price")
    addTaxPrice.innerHTML = taxPrice ;
    const profitPrice = parseInt(price - taxPrice)
    const profit = document.getElementById("profit")
    profit.innerHTML = profitPrice
  });
};

window.addEventListener('load', tax);
