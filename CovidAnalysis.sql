SELECT * FROM portfolio_project.covidvaccinations;

SELECT * FROM portfolio_project.coviddeaths;

SELECT Location, date, total_cases, new_cases,total_deaths,population 
FROM portfolio_project.coviddeaths
WHERE continent <> ""
order by 1;

-- Cheacking the total deaths vs total cases and calculation death % in India
SELECT Location, date, total_cases, total_deaths, 100*(total_deaths/total_cases) AS death_percentage
FROM portfolio_project.coviddeaths
WHERE location like '%India%' AND continent <> ""
order by 1;

-- Checking the Total Covid cases VS population in India

SELECT Location, date, total_cases, population, 100*(total_deaths/population) AS death_percentage_of_population
FROM portfolio_project.coviddeaths
WHERE location like '%India%' AND continent <> ""
order by 1;


-- Looking at highest infection rate compared to population of country

SELECT Location, MAX(total_cases),Population, MAX(total_cases/population)*100 AS InfectedPopulationPct
FROM portfolio_project.coviddeaths
WHERE continent <> ""
GROUP BY location, population
ORDER BY InfectedPopulationPct DESC;


-- Showing Countries with highest death count per population

SELECT Location, MAX(total_deaths),Population, MAX(total_deaths/population)*100 AS DeathPerPopulationPct
FROM portfolio_project.coviddeaths
WHERE continent <> ""
GROUP BY location, population
ORDER BY DeathPerPopulationPct DESC;

-- Comparing the Infected population in continent level
SELECT continent, MAX(total_cases), 100*MAX((total_cases/population)) AS InfectedPopulationPCT
FROM portfolio_project.coviddeaths
WHERE continent <> ""
GROUP BY continent
ORDER BY InfectedPopulationPCT DESC;


SELECT continent, MAX(total_deaths) AS TotalDeath, 100*MAX((total_deaths/population)) AS DeathPerPopulationPct
FROM portfolio_project.coviddeaths
WHERE continent <> ""
GROUP BY continent
ORDER BY MAX(total_deaths) DESC;

-- Finding the total deaths that occured in Asia
SELECT max(total_deaths) AS ASIADEATHS
FROM portfolio_project.coviddeaths
WHERE continent like '%Asia%';


-- Finding the death % across the world
SELECT SUM(new_deaths) AS TotalDeath, SUM(new_cases) AS TotalCases,  (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPct
FROM portfolio_project.coviddeaths;

-- Joining the death and vaccination table

SELECT * 
FROM portfolio_project.covidvaccinations VAC
JOIN portfolio_project.coviddeaths DEA
ON VAC.date = vac.date;

-- Checking the vaccination vs population

SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
FROM portfolio_project.covidvaccinations VAC
JOIN portfolio_project.coviddeaths DEA
ON VAC.date = vac.date AND VAC.location = DEA.location
WHERE dea.continent <> ""
GROUP BY 1,2,3;

