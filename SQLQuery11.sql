SELECT location,date,total_cases,total_deaths,population
FROM [portifolio project]..coviddeaths
order by 1,2

--looking at Total cases vs population
--Shows what percentage got covid
SELECT location,date,population,total_cases, (total_cases/population)*100 as deathPercentage
FROM [portifolio project]..coviddeaths
Where location like '%Aruba%'
order by 1,2

--Looking at countries with Highest Infection Rate compared to population
SELECT location,population,MAX(total_cases) AS HighestInfection, MAX((total_cases/population))*100 as PercntPopulation
FROM [portifolio project]..coviddeaths
Group by location,population
order by PercntPopulation desc

--country with the highest death count
SELECT location,MAX(cast(total_deaths as int)) AS totalDeathCount
FROM [portifolio project]..coviddeaths
Group by location
order by 1,2 desc

--lets break down by continent
SELECT continent,MAX(cast(total_deaths as int)) AS totalDeathCount
FROM [portifolio project]..coviddeaths
Group by continent
order by 1,2 asc

--showing continent with the highest deathcount
SELECT continent,MAX(cast(total_deaths as int)) AS totalDeathCount
FROM [portifolio project]..coviddeaths
Group by continent
order by 1,2 desc

SELECT *
FROM [portifolio project]..covidvaccinations
Join [portifolio project]..coviddeaths
ON coviddeaths.location=covidvaccinations.location
and coviddeaths.date=covidvaccinations.date

--looking at total population vs vaccinations
SELECT coviddeaths.continent,coviddeaths.date,coviddeaths.location,coviddeaths.population,covidvaccinations.new_vaccinations
,SUM(convert (int ,new_vaccinations)) Over (partition by coviddeaths.location)
FROM [portifolio project]..covidvaccinations
Join [portifolio project]..coviddeaths
ON coviddeaths.location=covidvaccinations.location
and coviddeaths.date=covidvaccinations.date
where coviddeaths.continent is not null
order by 1,3,4,2

  