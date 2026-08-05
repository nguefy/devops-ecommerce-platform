# ===========================
# Étape de compilation
# ===========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copier uniquement le projet
COPY DevOpsECommerce.Api.csproj ./

# Restaurer les dépendances
RUN dotnet restore

# Copier ensuite le reste du code
COPY . .

# Compiler et publier
RUN dotnet publish -c Release -o /app/publish --no-restore

# ===========================
# Étape d'exécution
# ===========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "DevOpsECommerce.Api.dll"]