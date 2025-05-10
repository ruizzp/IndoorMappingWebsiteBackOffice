# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia tudo para o container de build
COPY . ./

# Publica a aplicação
RUN dotnet publish IndoorMappingWebsite.csproj -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia os arquivos publicados da etapa anterior
COPY --from=build /app/out ./

# Define o ponto de entrada da aplicação
ENTRYPOINT ["dotnet", "IndoorMappingWebsite.dll"]