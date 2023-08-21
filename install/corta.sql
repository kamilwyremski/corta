

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin_logs`
--

CREATE TABLE IF NOT EXISTS `admin_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `logged` int(1) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin_session`
--

CREATE TABLE IF NOT EXISTS `admin_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `article`
--

CREATE TABLE IF NOT EXISTS `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `thumb` varchar(256) NOT NULL DEFAULT '',
  `content` longtext,
  `lid` varchar(512) NOT NULL DEFAULT '',
  `keywords` varchar(512) NOT NULL DEFAULT '',
  `description` varchar(512) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `article`
--

INSERT INTO `article` (`id`, `name`, `slug`, `thumb`, `content`, `lid`, `keywords`, `description`, `date`) VALUES
(1, 'Skrypt skracacza linków Corta', 'skrypt-skracacza-linkow-corta', 'upload/slider1.jpg', '<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n', 'Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.', 'pierwsze, drugie, trzecie', 'To jest description SEO. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.', '2020-01-01 12:42:59'),
(2, 'Twórz łatwe do zapamiętania adresy URL', 'tworz-latwe-do-zapamietania-adresy-url', 'upload/slider2.jpg', '<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n', 'Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. ', '', '', '2020-01-02 12:43:31'),
(3, 'Tnij i skracaj adresy URL', 'tnij-i-skracaj-adresy-url', 'upload/slider3.jpg', '<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n\r\n<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n\r\n<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n', 'Faucibus nisl tincidunt eget nullam non nisi. Aliquam id diam maecenas ultricies mi eget mauris pharetra. Ornare lectus sit amet est placerat. ', '', 'Faucibus nisl tincidunt eget nullam non nisi. Aliquam id diam maecenas ultricies mi eget mauris pharetra. Ornare lectus sit amet est placerat. ', '2020-01-03 12:44:13'),
(4, 'Krótkie adresy URL dzięki Corta', 'krotkie-adresy-url-dzieki-corta', 'upload/slider1.jpg', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Enim nunc faucibus a pellentesque sit amet porttitor eget. Fermentum odio eu feugiat pretium. Amet purus gravida quis blandit turpis. In fermentum et sollicitudin ac orci phasellus egestas. Massa sed elementum tempus egestas sed sed risus pretium. Pulvinar mattis nunc sed blandit libero volutpat. Egestas sed tempus urna et pharetra pharetra massa massa ultricies. Morbi blandit cursus risus at ultrices mi tempus imperdiet nulla. Dui ut ornare lectus sit amet. Facilisis mauris sit amet massa vitae tortor condimentum lacinia quis. Volutpat est velit egestas dui. Ac feugiat sed lectus vestibulum mattis. Vitae purus faucibus ornare suspendisse sed nisi. Aenean vel elit scelerisque mauris pellentesque pulvinar. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit amet. Lacus laoreet non curabitur gravida. Fermentum posuere urna nec tincidunt praesent semper feugiat nibh sed. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Id venenatis a condimentum vitae sapien pellentesque habitant morbi tristique.</p>\r\n\r\n<p>Eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis. Nunc non blandit massa enim nec dui nunc mattis enim. Vitae justo eget magna fermentum iaculis. Augue neque gravida in fermentum et sollicitudin. Sit amet volutpat consequat mauris nunc. Non consectetur a erat nam at lectus. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat. Pellentesque adipiscing commodo elit at imperdiet dui accumsan sit amet. Placerat in egestas erat imperdiet sed euismod nisi porta. Est velit egestas dui id.</p>\r\n\r\n<p>Lorem mollis aliquam ut porttitor leo. Cras tincidunt lobortis feugiat vivamus at augue eget arcu dictum. Pulvinar mattis nunc sed blandit. Massa placerat duis ultricies lacus sed turpis tincidunt. Egestas fringilla phasellus faucibus scelerisque eleifend donec. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Leo duis ut diam quam nulla porttitor massa id. Id aliquet lectus proin nibh nisl. Tortor condimentum lacinia quis vel eros donec ac. Viverra mauris in aliquam sem fringilla ut morbi tincidunt. Pellentesque eu tincidunt tortor aliquam nulla.</p>\r\n', 'Eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis. Nunc non blandit massa enim nec dui nunc mattis enim.', '', '', '2020-01-04 15:43:06');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `info`
--

CREATE TABLE IF NOT EXISTS `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `page` varchar(32) NOT NULL DEFAULT '',
  `content` longtext,
  `keywords` varchar(512) NOT NULL DEFAULT '',
  `description` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `info`
--

INSERT INTO `info` (`id`, `position`, `name`, `slug`, `page`, `content`, `keywords`, `description`) VALUES
(1, 2, 'Polityka prywatności', 'polityka-prywatnosci', 'privacy_policy', '<p>Ciasteczka (pliki cookie) i sygnalizatory WWW (web beacon)</p>\r\n\r\n<p>Zastrzegamy sobie możliwość do wykorzystania plik&oacute;w cookie (ciasteczek) oraz tzw session storage. Pliki te są zapisywane na Twoim komputerze. Służą one do:</p>\r\n\r\n<p>a) dostosowania zawartości serwisu&nbsp;do preferencji użytkownika oraz optymalizacji korzystania ze stron internetowych;,</p>\r\n\r\n<p>b) utrzymania sesji użytkownika serwisu internetowego (po zalogowaniu), dzięki kt&oacute;rej użytkownik nie musi na każdej podstronie serwisu ponownie wpisywać loginu i hasła,</p>\r\n\r\n<p>c) dostarczania użytkownikom treści reklamowych bardziej dostosowanych do ich zainteresowań.</p>\r\n\r\n<p>Serwis wyświetla reklamy pochodzące od zewnętrznych dostawc&oacute;w. Dostawcy reklam (np. Google) mogą używać ciasteczek i sygnalizator&oacute;w WWW, mogą uzyskać informację o Twoim adresie IP i typie używanej przeglądarki, sprawdzić czy zainstalowany jest dodatek Flash itp. Dzięki ciasteczkom, sygnalizatorom i znajomości adresu IP dostawcy reklam mogą decydować o treści reklam.&nbsp;</p>\r\n\r\n<p>Przeglądarki internetowe, oraz niekt&oacute;re Firewalle, umożliwiają wyłączenie obsługi ciasteczek i sygnalizator&oacute;w, lub jej ograniczenie dla wszystkich lub tylko dla wybranych stron WWW. Jednak wyłączenie obsługi ciasteczek i sygnalizator&oacute;w może uniemożliwić poprawne działanie naszego serwisu.&nbsp;</p>\r\n\r\n<p>Wsp&oacute;łczesne przeglądarki umożliwiają przeglądanie stron www tzw. &quot;trybie prywatnym (incognito)&quot; co zazwyczaj oznacza, że wszystkie odwiedzone strony www nie zostaną zapamiętane w lokalnej historii przeglądarki, a pobrane ciasteczka zostaną skasowane po zakończeniu pracy z przeglądarką. Szczeg&oacute;łowy opis &quot;trybu prywatnego&quot; jest dostępny w pomocy przeglądarki.</p>\r\n', '', ''),
(2, 4, 'Regulamin', 'regulamin', 'rules', '<ol>\r\n	<li>Regulamin stanowi prawną podstawę określającą zasady korzystania z naszej witryny. Odwiedzając naszą witrynę, akceptujesz aktualne postanowienia tego Regulaminu oraz zobowiązujesz się do przestrzegania wszystkich zawartych w nim zasad.<br />\r\n	Dopełnieniem Regulaminu jest nasza Polityka prywatności.</li>\r\n	<li>Charakter i cel witryny<br />\r\n	Witryna jest&nbsp;serwisem&nbsp;służącym do przechowywania link&oacute;w URL i ich skr&oacute;conych odpowiednik&oacute;w. Przy wejściu na skr&oacute;cony link witryna przekierowuje użytkownika na właściwy adres URL.</li>\r\n	<li>Udostępniając witrynę, zwracamy szczeg&oacute;lną uwagę na konieczność respektowania praw własności intelektualnej. Informujemy, że witryna&nbsp;zawierają&nbsp;dokumenty chronione prawem autorskim, znaki towarowe i inne oryginalne materiały, w szczeg&oacute;lności teksty, zdjęcia i grafikę, a przyjęty w witrynie&nbsp;wyb&oacute;r i układ prezentowanych w nim&nbsp;treści stanowi samoistny przedmiot ochrony prawnoautorskiej. Wszystkie loga, znaki towarowe oraz grafika zamieszczone na tych stronach są własnością ich tw&oacute;rc&oacute;w.</li>\r\n	<li>Serwis zastrzega możliwość blokowania kont w dowolnym czasie bez podania przyczyny.</li>\r\n	<li>Zawiadomienie o naruszeniu praw autorskich:<br />\r\n	Jeżeli uważasz, że Twoje lub czyjekolwiek prawa autorskie, prawa własności intelektualnej zostały w jakikolwiek spos&oacute;b bądź w jakiejkolwiek formie naruszone w witrynach, prosimy o przesłanie informacji w tej sprawie do wydawcy witryny.</li>\r\n	<li>Wyłączenia gwarancji<br />\r\n	W pełni akceptujesz, że wydawca udostępnia witrynę&nbsp;taką jaka jest.<br />\r\n	Zdajesz sobie sprawę, że opublikowane w witrynie materiały mogą zawierać informacje nieprawdziwe lub w inny spos&oacute;b nie odpowiadające Twoim potrzebom i oczekiwaniom. Zgadzasz się, że korzystasz z witryny&nbsp;tylko i wyłącznie na własną odpowiedzialność i własne ryzyko.<br />\r\n	Wszystkie informacje, materiały lub usługi dostarczane za pośrednictwem witryny oferowane są bez jakiejkolwiek gwarancji, w szczeg&oacute;lności:<br />\r\n	wydawca witryny nie zapewnia gwarancji dotyczących prawidłowości lub kompletności jakichkolwiek materiał&oacute;w, informacji lub ustaleń umieszczonych w witrynie.<br />\r\n	Odsyłacze do innych witryn, ogłoszenia i reklamy</li>\r\n	<li>W witrynie są publikowane odsyłacze do innych witryn. Mogą r&oacute;wnież być publikowane ogłoszenia firm - naszych Klient&oacute;w. Wydawca witryny nie ponosi żadnej odpowiedzialności za treść, ścisłość, zawartość lub dostępność informacji, do kt&oacute;rych prowadzą odsyłacze.</li>\r\n	<li>Rozstrzyganie spor&oacute;w<br />\r\n	W związku z możliwością wystąpienia spor&oacute;w związanych z korzystaniem z witryn:\r\n	<ul>\r\n		<li>zgadzasz się, że niniejszy Regulamin korzystania z witryn podlega prawu polskiemu - wszelkie spory mogące wyniknąć z wykonania zobowiązań zawartych w niniejszych warunkach będą rozstrzygane przez właściwy terytorialnie i rzeczowo sąd powszechny w Polsce.</li>\r\n		<li>zgadzasz się, że w przypadku, gdyby kt&oacute;rekolwiek z postanowień tego Regulaminu zostało uznane za niezgodne z prawem przez właściwy sąd, to decyzja sądu nie powoduje uchylenia innych postanowień tego Regulaminu i w związku z tym wszystkie inne postanowienia zachowują swoją moc.</li>\r\n		<li>zgadzasz się, że w przypadku niezgodności pomiędzy warunkami opisanymi w konkretnym dokumencie w witrynie&nbsp;i sygnowanym przez Wydawcę, a warunkami przedstawionymi w niniejszym Regulaminie, zawsze przyjmuje się za ważniejsze warunki określone w dokumencie, z wyjątkiem wyrażonych gdziekolwiek gwarancji, o kt&oacute;rych mowa była w rozdziale Wyłączenia gwarancji.</li>\r\n	</ul>\r\n	</li>\r\n	<li>Zmiany regulaminu korzystania z witryny<br />\r\n	Zgadzasz się, że Wydawca serwisu zastrzega sobie wyłączne prawo do wprowadzania zmian w witrynie w dowolnym czasie bez potrzeby informowania użytkownik&oacute;w. Użytkownicy odpowiedzialni są za regularne przeglądanie tych warunk&oacute;w oraz zastrzeżeń, a następujące po wszelkich zmianach korzystanie z witryn jest r&oacute;wnoznaczne z ich akceptacją.</li>\r\n</ol>\r\n\r\n<p><span style=\"color:#696969;\">Ostatnia aktualizacja regulaminu: 1.01.2020</span></p>\r\n', '', ''),
(3, 1, 'Kontakt', 'kontakt', 'contact', '', '', ''),
(4, 3, 'Przykładowa strona informacyjna', 'przykladowa-strona-informacyjna', '', '<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n\r\n<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.</p>\r\n', 'słowo 1, słowo 2, słowo 3, słowo 4', 'Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. ');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `link`
--

CREATE TABLE IF NOT EXISTS `link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(2048) NOT NULL,
  `short_url` varchar(128) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `short_url_2` (`short_url`),
  KEY `short_url` (`short_url`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logs_link`
--

CREATE TABLE IF NOT EXISTS `logs_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logs_mail`
--

CREATE TABLE IF NOT EXISTS `logs_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(64) NOT NULL,
  `action` varchar(32) NOT NULL,
  `content` mediumtext NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mails`
--

CREATE TABLE IF NOT EXISTS `mails` (
  `name` varchar(64) NOT NULL,
  `full_name` varchar(64) NOT NULL,
  `subject` mediumtext NOT NULL,
  `message` mediumtext NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `mails`
--

INSERT INTO `mails` (`name`, `full_name`, `subject`, `message`) VALUES
('contact_form', 'Contact form', 'Wiadomość z formularza kontaktowego strony {title}', '<p>Witaj!</p>\r\n\r\n<p>Została do Ciebie wysłana wiadomość z formularza kontaktowego ze strony {base_url}</p>\r\n\r\n<p>Nadawca: {name}</p>\r\n\r\n<p>Adres email: {email}</p>\r\n\r\n<p>Wiadomość: {message}</p>\r\n'),
('newsletter_add', 'Newsletter - add', 'Potwierdź chęć zapisu do newslettera na stronie {title}', '<p>Witaj!</p>\r\n\r\n<p>Aby potwierdzić chęć zapisu do newslettera na stronie {title} kliknij w poniższy link:</p>\r\n\r\n<p><a href=\"{newsletter_activation_link}\">{newsletter_activation_link}</a></p>\r\n\r\n<p>Pozdrawiamy<br />\r\n{title}<br />\r\n<br />\r\n<a href=\"{base_url}\">{link_logo}</a></p>\r\n');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mails_queue`
--

CREATE TABLE IF NOT EXISTS `mails_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(64) NOT NULL,
  `action` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  `priority` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `newsletter`
--

CREATE TABLE IF NOT EXISTS `newsletter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `code` varchar(64) NOT NULL,
  `active` int(1) NOT NULL DEFAULT '0',
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `session_link`
--

CREATE TABLE IF NOT EXISTS `session_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `settings`
--

INSERT INTO `settings` (`name`, `value`) VALUES
('ads_1', '<br><div class=\"container text-center\" style=\"max-width: 1140px;\"><div style=\"border: solid 1px #cfcfcf; padding: 10px;\"><p style=\"margin-bottom:0\">Boks reklamowy 1</p></div></div><br>'),
('ads_2', '<br><div class=\"container text-center\" style=\"max-width: 1140px;\"><div style=\"border: solid 1px #cfcfcf; padding: 10px;\"><p style=\"margin-bottom:0\">Boks reklamowy 2</p></div></div><br>'),
('ads_3', '<div class=\"container text-center\" style=\"max-width: 1140px;\"><div style=\"border: solid 1px #cfcfcf; padding: 10px;\"><p style=\"margin-bottom:0\">Boks reklamowy 3</p></div></div>'),
('ads_4', '<div class=\"container text-center\" style=\"max-width: 1140px;\"><div style=\"border: solid 1px #cfcfcf; padding: 10px;\"><p style=\"margin-bottom:0\">Boks reklamowy 4</p></div></div>'),
('allow_comments_fb_article', '1'),
('analytics', ''),
('base_url', ''),
('black_list_domains', ''),
('black_list_email', ''),
('black_list_ip', ''),
('check_ip_user', '1'),
('code_body', ''),
('code_head', ''),
('code_style', ''),
('description', 'Skrypt skracacza linków URL Corta. Umożliwia generowanie krótkich linków.'),
('email', ''),
('enable_articles', '1'),
('facebook_lang', 'pl_PL'),
('facebook_side_panel', ''),
('favicon', ''),
('footer_bottom', '<p class=\"mb-2\">Strona pokazowa skryptu skracania link&oacute;w CORTA</p>'),
('footer_top', '<p>CORTA to skrypt strony www służącej do skracania&nbsp;link&oacute;w URL.&nbsp;Dzięki niemu długi, nieprzyjazny adres URL zamienisz na kr&oacute;tki i łatwy do zapamiętania.</p>\r\n\r\n<p>Zainteresowanych zapraszam do zakupu na <a href=\"https://sklep.itworksbetter.net/skrypty-stron-www/7-skrypt-skracacza-linkow-corta.html\" title=\"Skrypt skracacza linków Corta\">sklep.itworksbetter.net/skrypty-stron-www/7-skrypt-skracacza-linkow-corta.html</a></p>\r\n'),
('generate_sitemap', '1'),
('index_page', '<h4 style=\"text-align:center\">PODAJ ADRES URL DO SKR&Oacute;CENIA</h4>\r\n'),
('index_page_2', '<h3 style=\"text-align:center\">WITAJ W SKRYPCIE SKRACACZA LINK&Oacute;W CORTA</h3>\r\n\r\n<p style=\"text-align:center\">Zamień długie linki na kr&oacute;tkie i łatwe do zapamiętania! Zarabiaj na reklamach na własnej stronie do skracania link&oacute;w URL!</p>\r\n\r\n<p style=\"text-align:center\">To jest strona pokazowa, możesz zobaczyć jak wygląda Panel Administracyjny:</p>\r\n\r\n<p style=\"text-align:center\"><a href=\"https://corta.itworksbetter.net/admin\" target=\"_blank\" title=\"Panel administracyjny strony Corta\">corta.itworksbetter.net/admin</a><br />\r\nlogin: test<br />\r\nhasło: 1234</p>\r\n\r\n<p style=\"text-align:center\">Ta strona internetowa służy pokazaniu funkcjonalności skryptu Corta. Zainteresowanych zakupem zapraszam na&nbsp;<a href=\"https://sklep.itworksbetter.net/skrypty-stron-www/7-skrypt-skracacza-linkow-corta.html\" target=\"_blank\" title=\"Kup skrypt skracacza linków Corta\">sklep.itworksbetter.net/skrypty-stron-www/7-skrypt-skracacza-linkow-corta.html</a></p>\r\n\r\n'),
('keywords', 'skrypt skracasz linków, krótki link, krótkie linki, url shortener, url short'),
('lang', 'pl'),
('logo', ''),
('logo_facebook', ''),
('mail_attachment', '1'),
('min_length_url', '4'),
('recaptcha_secret_key', ''),
('recaptcha_site_key', ''),
('rodo_alert', '1'),
('rodo_alert_text', '<p>Szanowny użytkowniku,<br />\r\npragniemy Cię poinformować, że nasz serwis internetowy może personalizować treści marketingowe do Twoich potrzeb. W związku z tym danymi osobowymi, kt&oacute;re przetwarzamy są np. Tw&oacute;j adres IP, dane pozyskiwane na podstawie plik&oacute;w cookies lub podobnych mechanizm&oacute;w na Twoim urządzeniu o ile pozwolą one na zidentyfikowanie Ciebie.&nbsp;<br />\r\nJeżeli klikniesz przycisk &bdquo;Wyrażam zgodę na przetwarzanie moich danych osobowych&rdquo; lub zamkniesz to okno, to wyrazisz zgodę na przetwarzanie Twoich danych przez właściciela witryny i jego zaufanych partner&oacute;w.<br />\r\nWyrażenie zgody jest dobrowolne. Masz prawo do: dostępu do Twoich danych, ich sprostowania oraz usunięcia. Więcej informacji odnośnie przetwarzania danych osobowych znajdziesz w naszej <a href=\"/info/1,polityka-prywatnosci\">Polityce Prywatności.</a></p>\r\n\r\n<p>Lista zaufanych partner&oacute;w:<br />\r\nGoogle - na stronie są zamieszczone kody reklam Adsense oraz Google Analytics, kt&oacute;re mają na celu wyświetlanie spersonalizowanych treści oraz zbieranie informacji o zachowaniu użytkownika w celu poprawy strony.<br />\r\nFacebook - na stronie zamieszczony jest kod Facebook mający na celu wyświetlanie boksu z komentarzami oraz panelu bocznego.</p>\r\n\r\n<p>Jest to demo skryptu, w kt&oacute;rym dostęp do Panelu Administratora mają wszyscy użytkownicy. Dlatego też w panelu mogą zobaczyć Tw&oacute;j login, adres IP i inne dane (bez adresu email) jeśli zarejestrujesz się na stronie lub podejmiesz inne działanie. Prosimy mieć to na względzie.</p>\r\n'),
('smtp', ''),
('smtp_host', ''),
('smtp_mail', ''),
('smtp_password', ''),
('smtp_port', '465'),
('smtp_secure', 'ssl'),
('smtp_user', ''),
('social_facebook', '1'),
('social_pinterest', '1'),
('social_twitter', '1'),
('social_wykop', '1'),
('template', 'default'),
('time_to_redirect', '4'),
('title', 'Corta - skrypt skracacza linków'),
('url_facebook', ''),
('url_privacy_policy', 'polityka-prywatnosci'),
('url_rules', 'regulamin');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `slider`
--

INSERT INTO `slider` (`id`, `content`) VALUES
(1, '<p><img alt=\"Corta\" class=\"d-block w-100\" src=\"upload/slider1.jpg\" /></p>\r\n\r\n<div class=\"carousel-caption d-none d-md-block\">\r\n<h3>Skrypt skracacza linków Corta</h3>\r\n\r\n<p>Zamień długi adres URL na krótki i łatwy!</p>\r\n\r\n</div>\r\n'),
(2, '<p><img alt=\"Skrypt Corta\" class=\"d-block w-100\" src=\"upload/slider2.jpg\" /></p>\r\n\r\n<div class=\"carousel-caption d-none d-md-block\">\r\n<h3>Podaj adres do skrócenia i kliknij Dodaj</h3>\r\n</div>\r\n'),
(3, '<p><img alt=\"Skrypt Corta\" class=\"d-block w-100\" src=\"upload/slider3.jpg\" /></p>\r\n\r\n<div class=\"carousel-caption d-none d-md-block\">\r\n<h3>Stwórz własną stronę i zacznij zarabiać</h3>\r\n\r\n<p>Możesz dodać na stronę reklamy i dzięki nim mieć pasywny dochód!</p>\r\n\r\n</div>\r\n');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
