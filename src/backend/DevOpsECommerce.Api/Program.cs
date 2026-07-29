using DevOpsECommerce.Api.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var products = new List<Product>
{
    new()
    {
        Id = 1,
        Name = "Mechanical Keyboard",
        Description = "RGB Mechanical Keyboard",
        Price = 89.99m,
        Stock = 15
    },
    new()
    {
        Id = 2,
        Name = "Gaming Mouse",
        Description = "Wireless Gaming Mouse",
        Price = 49.99m,
        Stock = 30
    }
};

app.MapGet("/api/products", () =>
{
    return Results.Ok(products);
})
.WithName("GetProducts")
.WithOpenApi();

app.Run();
