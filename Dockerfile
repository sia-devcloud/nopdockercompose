FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
LABEL author="Shahinur Islam Ahmed"
LABEL application="nopCommerce"

RUN git clone "https://github.com/nopSolutions/nopCommerce.git"
WORKDIR /nopCommerce
RUN mkdir /nopCommerce/published
RUN dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o /nopCommerce/published
RUN mkdir /nopCommerce/published/bin
RUN mkdir /nopCommerce/published/logs

FROM mcr.microsoft.com/dotnet/aspnet:8.0
RUN mkdir /app
COPY --from=build /nopCommerce/published /app
WORKDIR /app
EXPOSE 5000
CMD ["dotnet","Nop.Web.dll","--urls","http://0.0.0.0:5000"]