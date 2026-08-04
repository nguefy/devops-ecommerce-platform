using Microsoft.EntityFrameworkCore;
using DevOpsECommerce.Api.Models;

namespace DevOpsECommerce.Api.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Product> Products => Set<Product>();
}
