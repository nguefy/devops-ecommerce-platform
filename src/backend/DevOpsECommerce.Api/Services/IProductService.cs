using DevOpsECommerce.Api.Models;

namespace DevOpsECommerce.Api.Services;

public interface IProductService
{
    IEnumerable<Product> GetAllProducts();
}
