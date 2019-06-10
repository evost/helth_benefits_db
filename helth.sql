-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июн 10 2019 г., 12:50
-- Версия сервера: 5.7.26
-- Версия PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `helth`
--

-- --------------------------------------------------------

--
-- Структура таблицы `benefits_docs`
--

CREATE TABLE `benefits_docs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` mediumtext NOT NULL,
  `ser_number` text NOT NULL,
  `department` mediumtext NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Дамп данных таблицы `benefits_docs`
--

INSERT INTO `benefits_docs` (`id`, `name`, `ser_number`, `department`, `date`) VALUES
(1, 'Пенсионное удостоверение', '2344 665467', 'МО №3 ПФР', '2013-10-10'),
(2, 'Пенсионное удостоверение', '1233 453298', 'МО №4 ПФР ', '2010-05-09');

-- --------------------------------------------------------

--
-- Структура таблицы `benefits_types`
--

CREATE TABLE `benefits_types` (
  `guid` char(38) NOT NULL,
  `type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Структура таблицы `drugs`
--

CREATE TABLE `drugs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Структура таблицы `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `surname` text NOT NULL,
  `name` text NOT NULL,
  `patronymic` text,
  `birthdate` date NOT NULL,
  `insurance` text,
  `gender` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Дамп данных таблицы `patients`
--

INSERT INTO `patients` (`id`, `surname`, `name`, `patronymic`, `birthdate`, `insurance`, `gender`) VALUES
(3, 'Семенов', 'Вячеслав', 'Тимурович', '1968-09-04', 'СН 52148321', 1),
(4, 'Крылова', 'Таисия', 'Богдановна', '1988-07-06', 'ПК 59856215', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `recipients`
--

CREATE TABLE `recipients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient` bigint(20) UNSIGNED NOT NULL,
  `benefit_doc` bigint(20) UNSIGNED NOT NULL,
  `drug` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `count` int(10) UNSIGNED NOT NULL,
  `benefit_type` char(38) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `benefits_docs`
--
ALTER TABLE `benefits_docs`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `benefits_types`
--
ALTER TABLE `benefits_types`
  ADD UNIQUE KEY `guid` (`guid`);

--
-- Индексы таблицы `drugs`
--
ALTER TABLE `drugs`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `patients`
--
ALTER TABLE `patients`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `recipients`
--
ALTER TABLE `recipients`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `benefit_doc` (`benefit_doc`),
  ADD KEY `drug` (`drug`),
  ADD KEY `patient` (`patient`),
  ADD KEY `benefit_type` (`benefit_type`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `benefits_docs`
--
ALTER TABLE `benefits_docs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `drugs`
--
ALTER TABLE `drugs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `patients`
--
ALTER TABLE `patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `recipients`
--
ALTER TABLE `recipients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `recipients`
--
ALTER TABLE `recipients`
  ADD CONSTRAINT `recipients_ibfk_1` FOREIGN KEY (`benefit_doc`) REFERENCES `benefits_docs` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `recipients_ibfk_3` FOREIGN KEY (`drug`) REFERENCES `drugs` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `recipients_ibfk_4` FOREIGN KEY (`patient`) REFERENCES `patients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `recipients_ibfk_5` FOREIGN KEY (`benefit_type`) REFERENCES `benefits_types` (`guid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
