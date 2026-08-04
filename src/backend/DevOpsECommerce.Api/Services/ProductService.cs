using DevOpsECommerce.Api.Data;
using DevOpsECommerce.Api.Models;

namespace DevOpsECommerce.Api.Services;

public class ProductService : IProductService
{
    private readonly ApplicationDbContext _context;

    public ProductService(ApplicationDbContext context)
    {
        _context = context;
    }

    public IEnumerable<Product> GetAllProducts()
    {
        return _context.Products.ToList();
    }
}
