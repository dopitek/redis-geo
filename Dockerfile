FROM microsoft/aspnetcore-build:2.0 AS build-env
COPY src /app
WORKDIR /app

RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/poc/out .
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["dotnet", "poc.dll"]