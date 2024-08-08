# Use the official ASP.NET runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
RUN apt-get update && apt-get install -y --no-install-recommends \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
EXPOSE 80

# Use the official ASP.NET SDK as a build image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["AspCoreWebAPICrud.csproj", "./"]
RUN dotnet restore "AspCoreWebAPICrud.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "AspCoreWebAPICrud.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AspCoreWebAPICrud.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AspCoreWebAPICrud.dll"]
