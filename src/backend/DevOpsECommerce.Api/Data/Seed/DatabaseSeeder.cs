using DevOpsECommerce.Api.Models;

namespace DevOpsECommerce.Api.Data.Seed;

public static class DatabaseSeeder
{
    public static void Seed(ApplicationDbContext context)
    {
        if (context.Products.Any())
        {
            return;
        }

        var products = new List<Product>
        {
            new Product
            {
                Name = "Laptop",
                Price = 1200
            },
            new Product
            {
                Name = "Keyboard",
                Price = 80
            }
        };

        context.Products.AddRange(products);

        context.SaveChanges();
    }
}
