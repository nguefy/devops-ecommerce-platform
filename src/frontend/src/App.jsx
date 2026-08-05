import { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
  fetch("/api/products")
    .then((response) => {
      console.log("HTTP status:", response.status);
      return response.json();
    })
    .then((data) => {
      console.log("Produits reçus :", data);
      setProducts(data);
    })
    .catch((error) => {
      console.error("Erreur API :", error);
    });
}, []);

  return (
    <div className="container">
      <h1>DevOps E-Commerce</h1>

      <h2>Products</h2>

      <ul>
        {products.map((product) => (
          <li key={product.id}>
            {product.name} - {product.price} €
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
