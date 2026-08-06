using DevOpsECommerce.Api.Models;
using DevOpsECommerce.Api.Services;
using Microsoft.EntityFrameworkCore;
using DevOpsECommerce.Api.Data;
using DevOpsECommerce.Api.Data.Seed;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddCors(options =>
{
    options.AddPolicy("frontend", policy =>
    {
        policy
            .WithOrigins("http://localhost:5173")
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});


builder.Services.AddControllers();

builder.Services.AddScoped<IProductService, ProductService>();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("Postgres")
    ));

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseCors("frontend");

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider
        .GetRequiredService<ApplicationDbContext>();

    var availableMigrations = dbContext.Database.GetMigrations();

    foreach (var migration in availableMigrations)
    {
        Console.WriteLine($"AVAILABLE MIGRATION: {migration}");
    }

    dbContext.Database.Migrate();

    DatabaseSeeder.Seed(dbContext);
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapControllers();

app.MapGet("/health", () => Results.Ok(new
{
    status = "Healthy"
}));

app.Run();
