function tax (){
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener("keyup", () => {
    const price = itemPrice.value;
    const taxPrice = Math.floor(price / 10)
    const addTaxPrice = document.getElementById("add-tax-price")
    addTaxPrice.innerHTML = taxPrice ;
    const profitPrice = Math.floor(price - taxPrice)
    const profit = document.getElementById("profit")
    profit.innerHTML = profitPrice
  });
};

window.addEventListener('load', tax);
