using DevOpsECommerce.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace DevOpsECommerce.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly IProductService _productService;

    public ProductsController(IProductService productService)
    {
        _productService = productService;
    }

    [HttpGet]
    public IActionResult GetProducts()
    {
        var products = _productService.GetAllProducts();

        return Ok(products);
    }
}
