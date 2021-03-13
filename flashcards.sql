-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 13 Mar 2021, 21:02
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `flashcards`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `card`
--

CREATE TABLE `card` (
  `id` int(11) NOT NULL,
  `front` mediumtext DEFAULT NULL,
  `back` mediumtext DEFAULT NULL,
  `importance` int(1) DEFAULT NULL,
  `last_check` datetime DEFAULT NULL,
  `one_sided` tinyint(4) DEFAULT NULL,
  `card_group_id` int(11) NOT NULL,
  `seconds` int(10) NOT NULL DEFAULT 1800
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `card`
--

INSERT INTO `card` (`id`, `front`, `back`, `importance`, `last_check`, `one_sided`, `card_group_id`, `seconds`) VALUES
(2, 'Iloczyn skalarany wektorów', 'Mnożenie wektorów', 1, '2020-12-12 21:05:21', 0, 4, 1800),
(68, 'tg(60<sup>o</sup>)', 'sqrt(3)', 1, '2021-01-04 11:24:51', 0, 55, 54000),
(69, 'Wzór na równanie kierunkowe prostej', 'y = ax + b', 2, '2021-01-04 11:25:01', 0, 55, 28800),
(70, 'Równanie prostej w postaci ogólnej', 'A<sub>x</sub> + B<sub>y</sub> + C = 0 \n\nA,B,C należą do R\n\nA<sup>2</sup> + B<sup>2</sup> != 0', 1, '2021-01-04 11:25:09', 0, 55, 72000),
(71, 'A(3,-4), B(11, -4)\nCzy prosta jest stała?', 'Tak, y jest nie zmienny, a więc prosta jest stała', 1, '2021-01-04 11:25:13', 0, 55, 72000),
(72, '2 = -3a +b\n9 = 4a + b\n\n-7 = -7a\na = 1\n2 = -3 + b\nb = 5\ny = (a)x + 5\nx - y + 5 = 0', '', 1, '2021-01-04 11:25:15', 1, 55, 72000),
(73, 'A<sub>x</sub> + B<sub>y</sub> + C = 0\nP(2, 2), Q(-1,0)\nWyznacz równanie ogólne i kierunkowe', '2A + 2B + C = 0\n-A + C = 0\n\nA = C\n2C + 2B + C = 0\n3C + 2B = 0\nB = -3/2C\nniech c=2 =>\nA = 2\nB = -3\n2x - 3y + 2', 1, '2021-01-04 11:25:30', 0, 55, 72000),
(74, 'Jeżeli mamy układ 2 równań z 3 niewiadomymi to:', 'Układ ma nieskończoną ilość rozwiązań, znajdujemy je podstawiając liczbę do jednej z niewiadomych', 2, '2021-01-04 11:25:46', 0, 55, 28800),
(75, '(0, -4), (3, 1)', '-4B + C = 0\n3A + B + C = 0\n\nC = 4B\n3A + 5B = 0\nA = - 5/3B\npodstawiamy pod C', 1, '2021-01-04 11:25:51', 0, 55, 72000),
(76, 'x - my + m + 4 = 0\n2mx + y - m -1 = 0\nWstawiamy w miejsce x = 0\n-my + m + 4 = 0\ny - m - 1 = 0\ny = m + 1\n-m(m+1) + m + 4 = 0\n-m<sup>2</sup> + 4 = 0\n -m<sup>2</sup> = -4\nm<sup>2</sup> = 4\nm = 2 v m = -2', '', 1, '2021-01-04 11:25:59', 1, 55, 72000),
(77, 'u = [-1,2], P(3,4)\nA<sub>x</sub> + B<sub>y</sub> + C = 0\n-x +2y + C = 0\n-x + 2y +C = 0\n-3 + 8 + C = 0\nC = -5\n-x + 2y -5 = 0\ny = 1/2x + 5/2', '', 1, '2021-01-04 11:26:27', 1, 56, 72000),
(78, 'u = [6,1], P(2,5)\n6x + y + C = 0\n2x + 5y + C = 0\n', '', 1, '2021-01-04 11:26:31', 1, 56, 72000),
(79, 'prosta k - A<sub>1</sub>x + B<sub>1</sub>y + C<sub>1</sub> = 0\nprosta l - A<sub>2</sub>x + B<sub>2</sub>y + C<sub>2</sub> = 0\ncosinus kąta pomiędzy tymi prostymi =', 'A<sub>1</sub>A<sub>2</sub> + B<sub>1</sub>B<sub>2</sub>\n_____________________\n\nsqrt(A<sub>1</sub><sup>2</sup>+B<sub>1</sub><sup>2</sup>) * sqrt(A<sub>2</sub><sup>2</sup> * B<sub>2</sub><sup>2</sup>)\n', 1, '2021-01-04 12:09:18', 0, 56, 10800),
(80, 'sinus kąta pomiędzy to:', 'A1B2−A2B1\n_______________________\n\n√A21+ B21 * √A22+B22', 1, '2021-01-04 11:27:45', 0, 56, 54000),
(81, 'Warunek równoległości prostych k i l', 'A<sub>1</sub>B<sub>2</sub> - A<sub>2</sub>B<sub>1</sub> = 0', 3, '2021-01-04 11:28:09', 0, 56, 28800),
(82, 'Warunek prostopadłości prostych k i l:', 'A<sub>1</sub>A<sub>2</sub> + B<sub>1</sub>B<sub>2</sub> = 0', 3, '2021-01-04 11:28:23', 0, 56, 28800),
(83, 'k: (m-1)x + (m+1)y - 5m = 0\nl: 3x - 2y + 4 = 0\nCzy proste są równoległe?', '-2(m-1) - 3(m+1) = 0\n-2m + 2 - 3m - 3 = 0\n-5m = 1\nm = -1/5', 2, '2021-01-04 11:28:51', 0, 57, 28800),
(84, 'k: -x + (2a - 1)y - 10 = 0\nl: (a+7)x + 2y + 8 = 0\nWyznacz liczbę a, dla której proste k i l są prostopadłe:\n-1(a+7) + 2(2a - 1) = 0\n-a - 7 + 4a -2 = 0\n3a = 9\na = 3', '', 2, '2021-01-04 11:28:53', 1, 57, 28800),
(85, 'Jak wyznacza się współczynnik kierunkowy:', 'y<sub>2</sub> - y<sub>1</sub>\n____________________\nx<sub>2</sub> - x<sub>1</sub>', 1, '2021-01-04 11:29:03', 0, 57, 61200),
(86, 'Równanie symetralnej: ', 'y = -(1/a)x+b\na = 1\ny = -x + b\n0 = -1 + b\nb = 1\ny = -x + 1', 1, '2021-01-04 11:29:40', 0, 57, 61200),
(87, 'Wzór na prostopadłość prostych w postaci kierunkowej:', 'a<sub>1</sub> * a<sub>2</sub> = -1', 1, '2021-01-04 11:29:54', 0, 58, 28800),
(88, 'Częstym sposobem obliczania punktów w zadaniach jest punkt wspólny 2 prostych, lub środek odcinka pomiędzy dwoma punktami', '', 1, '2021-01-04 11:30:03', 1, 58, 57600),
(89, 'Wzór na odległość punktu od prostej:', 'd(l; P) = |A<sub>x</sub><sub>0</sub> + B<sub>y</sub><sub>0</sub> + C|\n________________________\n\nsqrt(A<sup>2</sup> + B<sup>2</sup>)\n\nGdzie x<sub>0</sub> oraz y<sub>0</sub> to współrzędne punktu P, a A i B to kierunkowe prostej', 1, '2021-01-04 11:30:58', 0, 58, 28800),
(90, 'Pole czworokąta wpisanego w okrąg:', 'sqrt((p-a)(p-b)(p-c)(p-d)), gdzie p =1/2(a+b+c+d)\np to połowa obwodu', 1, '2021-01-04 11:36:12', 0, 59, 57600),
(91, 'Kąty przeciwległe czworokąta wpisanego w okrąg:', 'Dają sumę 180<sup>o</sup>', 1, '2021-01-04 11:36:17', 0, 59, 57600),
(92, 'Pole czworokąta opisanego na okręgu o promieniu r:', '1/2 * r * ( a + b + c + d )', 1, '2021-01-04 11:36:25', 0, 59, 57600),
(93, 'Sumy długości przeciwległych boków czworokąta opisanego na okręgu są:', 'równe, a więc a + c = b + d', 1, '2021-01-04 11:36:29', 0, 59, 57600),
(94, 'Wzór na pole kwadratu używając długości przekątnej:', 'd<sup>2</sup> / 2 - gdzie d to długość przekątnej', 1, '2021-01-04 11:36:37', 0, 59, 57600),
(95, 'Wzór na pole trójkąta równobocznego', 'P = (a<sup>2</sup>√3) / 4', 1, '2021-01-04 11:36:44', 0, 59, 57600),
(96, 'Przekątne w rombie dzielą się na 2 równe części pod kątem prostym', '', 1, '2021-01-04 11:36:47', 1, 59, 57600),
(97, 'W zadaniach pojawia się trójkąt równoboczny', '', 1, '2021-01-04 11:36:49', 1, 59, 57600),
(98, 'Oś symetrii odcinka, a więc jego środek wyznaczamy jako:', 'x = ( x<sub>1</sub> + x<sub>2</sub> ) / 2, gdzie x<sub>1</sub> to x początku odcinka, a x<sub>2</sub> to x końca odcinka i w taki sam sposób y = ( y<sub>1</sub> + y<sub>2</sub> ) / 2', 2, '2021-01-04 11:38:44', 0, 60, 43200),
(99, 'Wzór na ilość przekątnych wielokąta:', '( ( n - 3 ) * n ) / 2', 1, '2021-01-04 11:38:52', 0, 60, 57600),
(100, 'Aby proste były symetryczne względem osi O<sub>x</sub> a więc ich osią symetrii była oś O<sub>x</sub>, to istnieją 2 takie przypadki', 'a) Kiedy proste przecinają się na osi O<sub>x</sub> oraz ich współczynnik kierunkowy i wyraz wolny są przeciwne\n\nb) Kiedy ich współczynniki kierunkowe są równe 0 - funkcja stała, a ich wyrazy wolne są przeciwne', 1, '2021-01-04 11:39:19', 0, 60, 57600),
(101, 'Odległość pomiędzy dwoma punktami to innaczej długość wektora przesunięcia pomiędzy tema 2 punktami, a więc liczymy:', '√ | x<sub>1</sub> - x<sub>2</sub> |<sup>2</sup> + | y<sub>1</sub> - y<sub>2</sub> |<sup>2</sup>', 1, '2021-01-04 11:39:42', 0, 60, 57600),
(102, 'Wzór na sumę kątów wielokąta:', '( n - 2 ) * 180<sup>o</sup>', 1, '2021-01-04 11:39:51', 0, 60, 57600),
(103, 'Wzór na współczynnik kierunkowy a, mając 2 punkty:', 'y<sub>2</sub> - y<sub>1</sub>\n_____________\n\nx<sub>2</sub> - x<sub>1</sub>', 1, '2021-01-04 11:40:03', 0, 60, 57600),
(104, 'Aby obliczyć nierówność musimy obliczyć miejsca zerowe za pomocą Δ oraz wzorów na x<sub>1</sub> oraz x<sub>2</sub>', '', 2, '2021-01-04 11:40:09', 1, 61, 28800),
(105, 'Kierunek funkcji zależy od Współczynnika kierunkowego a', '', 2, '2021-01-04 11:40:12', 1, 61, 43200),
(106, 'Po naszkicowaniu funkcji wiadomo w jakim zakresie mieści się x', '', 1, '2021-01-04 11:40:14', 1, 61, 28800),
(107, 'Dla równań z 1 miejscem zerowym, nierówność x<0 lub x>0 jest sprzeczna. Natomiast dla x<=0 lub x>=0  rozwiązaniem jest miejsce zerowe.', '', 1, '2021-01-04 11:40:36', 1, 61, 28800),
(108, 'a > 0 - ramiona funkcji skierowane w górę', '', 1, '2021-01-04 11:40:38', 1, 61, 57600),
(109, 'a < 0 - ramiona funkcji skierowane w dół', '', 1, '2021-01-04 11:40:39', 1, 61, 57600),
(110, 'Równanie: ax<sup>2</sup> + bx + c = 0\nDelta = b<sup>2</sup> - 4ac\nx<sub>1</sub> = -b - sqrt(Delta) / 2a\nx<sub>2</sub> = -b + sqrt(Delta) / 2a', '', 1, '2021-01-04 11:37:01', 1, 62, 28800),
(111, 'Aby sprawdzić czy dany punkt należy do wykresu funkcji należy:', 'Podstawić x oraz y pod wzór funkcji. Jeżeli Lewa Strona = Prawa Strona, L=P to znaczy, że punkt należy do wykresu funkcji', 1, '2021-01-04 11:40:56', 0, 63, 28800),
(112, 'Postać kanoniczna:', 'f(x) = a(x - p)<sup>2</sup> + q', 2, '2021-01-04 11:41:09', 0, 63, 28800),
(113, 'Wzór na q:', '-Δ/4a', 2, '2021-01-04 11:41:18', 0, 63, 28800),
(114, 'Dla Δ = 0', 'Funkcja ma 1 miejsce zerowe', 2, '2021-01-04 11:41:22', 0, 63, 28800),
(115, 'Punkt przecięcia się funkcji z osią y to wyraz wolny c funkcji kwadratowej', '', 2, '2021-01-04 11:41:26', 1, 63, 28800),
(116, 'Wierzchołek fukcji obliczamy z wzorów na p oraz q, Wierzchołek: (p,q) ->\n(x,y), p = x, q = y. Podaj wzory na p oraz q:', 'p = -b/2a\nq = -Δ/4a', 2, '2021-01-04 11:41:40', 0, 63, 28800),
(117, 'Postać ogólna', 'f(x) = ax<sup>2</sup> + bx + c', 2, '2021-01-04 11:41:47', 0, 63, 28800),
(118, 'Jeżeli Δ = 0, miejsce zerowe funkcji jest zarazem wierzchołkiem tej funkcji. A to miejsce zerowe obliczamy tak:', '-b / 2a', 1, '2021-01-04 11:42:08', 0, 63, 28800),
(119, 'Funkcja kwadratowa jest malejąca lub rosnąca od -∞ do argumentu x = p oraz rosnąca lub malejąca od p do +∞. Kolejność zależy od współczynnika kierunkowego a', '', 2, '2021-01-04 11:42:15', 1, 63, 28800),
(120, 'Dla Δ > 0', 'Funkcja ma 2 miejsca zerowe', 2, '2021-01-04 11:42:20', 0, 63, 28800),
(121, 'Jeśli znam 2 punkty należące do wykresu, natomiast nie znam a oraz q lub p:', 'Mogę obliczyć a oraz q albo a oraz p z układu równań podstawiając x i y należące do wykresu tej funkcji', 2, '2021-01-04 11:42:47', 0, 63, 28800),
(122, 'p - oś symetrii parabolii, można obliczyć za pomocą wzoru -b/2a, lub:', 'Obliczając średnią arytmetyczna miejsc zerowych: p = ( x<sub>1</sub> + x<sub>2</sub> ) / 2', 2, '2021-01-04 11:43:22', 0, 63, 28800),
(123, 'Wzór na p:', '-b/2a', 1, '2021-01-04 11:43:27', 0, 63, 28800),
(124, 'q - najmniejsza lub największa wartość funkcji kwadratowej, można obliczyć za pomocą wzoru - Δ/4a, lub:', 'q = f(p) - Licząc wartość funkcji dla argumentu p - oś symetrii paraboli', 2, '2021-01-04 11:43:33', 0, 63, 28800),
(125, 'Przekształcienie f(x)-m, gdzie m to współczynnik funkcji, powoduje:', 'Obniżenie się wykresu funkcji, zbiór wartości funkcji obniża się o m.', 1, '2021-01-04 11:43:42', 0, 64, 28800),
(126, 'Dla przekształcenia f(x-m), gdzie m to współczynnik przesunięcia:', 'Wykres funkcji przesuwa się o m w prawo - wartości funkcji występują o m później ( wolniej ) na wykresie.', 1, '2021-01-04 11:44:00', 0, 64, 28800),
(127, 'Przekształcenie -f(x) powoduje:', 'Odwrócenie się symetrycznie funkcji względem osi x', 1, '2021-01-04 11:44:15', 0, 64, 28800),
(128, 'Przekształcenie f(x)+m, gdzie m to współczynnik przekształcenia powoduje:', 'Podniesienie się wykresu funkcji, Zbiór wartości funkcji podnosi się o m.', 1, '2021-01-04 11:44:20', 0, 64, 57600),
(129, 'Przekształcenie f(-x) powoduje:', 'Obrócenie się funkcji symetrycznie względem osi y', 1, '2021-01-04 11:44:26', 0, 64, 28800),
(130, 'Dla przesunięcia f(x+m), gdzie m to współczynnik przesunięcia:', 'Wykres funkcji przesuwa się o m w lewo - wartości funkcji występują o m wcześniej ( szybciej ) na wykresie.', 1, '2021-01-04 11:44:37', 0, 64, 28800),
(131, 'Dla równania funkcji f(x)=-2/5x-2, aby narysować wykres funkcji najpierw zaznaczamy wyraz wolny -2 jako wartość na wykresie, a potem:', 'Tworzymy kolejne punkty funkcji na podstawie zmiennej kierunkowej -2/5, kolejne schodki powstają 2 w dół (-) oraz 5 punktów w prawo (+)', 1, '2021-01-04 11:44:51', 0, 65, 28800),
(132, 'Dla równania funkcji f(x)=2x+3, aby narysować wykres funkcji najpierw zaznaczamy wyraz wolny 3 jako wartość na wykresie, a potem:', 'Tworzymy punkty funkcji na podstawie zmiennej kierunkowej funkcji 2 = 2/1, kolejne schodki powstają 2 punkty w górę i 1 w prawo.', 1, '2021-01-04 11:44:57', 0, 65, 28800),
(133, 'Funkcje liniowe są równoległe, jeżeli ich współczynniki kierunkowe są takie same', '', 2, '2021-01-04 11:45:02', 1, 65, 28800),
(134, 'Funkcje liniowe są prostopadłe, jeżeli  iloczyn ich współczynników kierunkowych jest równy -1, a więc są przeciwne oraz odwrotne. np. f(x) = -1/2x + 2 oraz f(x) = 2/1x + 12', '', 2, '2021-01-04 11:45:10', 1, 65, 28800),
(135, 'Funkcja liniowa jest stała jeśli:', 'Jej współczynnik kierunkowy a = 0', 1, '2021-01-04 11:45:15', 0, 65, 28800),
(136, 'Funkcja liniowa jest rosnąca jeśli:', 'Współczynnik kierunkowy a>0', 1, '2021-01-04 11:45:17', 0, 65, 28800),
(137, 'Funkcja liniowa jest malejąca jeśli:', 'Współczynnik kierunkowy a < 0', 1, '2021-01-04 11:45:19', 0, 65, 57600),
(138, 'W nierównościach, np. | x - ½ | > √3, aby znaleźć rozwiązanie:', 'Znajdujemy takie liczby, które pasują do wyniku √3, a więc ½ + √3 oraz ½ - √3, zaznaczamy je na osi, oraz według nierówności, dla większych są to wszystkie oddalone bardziej niż te dwie liczby, a dla mniejszości są to te oddalone mniej, a więc te bliższe do ½', 2, '2021-01-04 11:46:59', 0, 70, 28800),
(139, 'Przy równaniach z wartością bezwzględną i niewiadomą, np. | x - 5 | = 2, wyniki znajdujemy poprzez:', 'Zaznaczenie na osi 5, po czym zaznaczenie liczb odległych o 2 w obydwie strony, to jest nasz wynik', 1, '2021-01-04 11:47:08', 0, 70, 28800),
(140, 'Wartość bezwzględną możemy rozdzielić na iloczyn dwóch liczb bezwzględnych np. | x<sup>2</sup> - 9 |, możemy rozdzielić na:', '| x - 3 | * | x + 3 |', 1, '2021-01-04 11:47:14', 0, 70, 28800),
(141, 'Przy rozwiązywaniu trudniejszych nierówności z wartościami bezwzględnymi, mamy rozgałęzienie, a więc dla nierówności | x - 13 | > 12 + √3, powstają dwie gałęzie:', 'x - 13 > 12 + √3   ∨   x - 13 < -12 - √3\nA więc dla drugiego rozgałęzienia zmieniamy znak nierówności na przeciwny oraz liczbę po drugiej stronie nierówności na przeciwną', 1, '2021-01-04 11:47:26', 0, 70, 28800),
(142, 'Kąt wpisany w okręgu oparty na tym samym łuku co kąt środkowy ma miarę:', '2 razy mniejszą od tego kąta środkowego. Tak samo kąt środkowy ma miarę 2 razy większą od kąta wpisanego opartego na tym samym łuku.', 1, '2021-01-04 11:48:17', 0, 66, 28800),
(143, 'Cechy podobieństwa trójkątów:', 'kąt-kąt-kąt, bok-bok-bok, bok-kąt-bok', 1, '2021-01-04 11:48:33', 0, 66, 28800),
(144, 'Trójkąt prostokątny wpisany w okrąg wyróżnia się tą zależnością:', 'Jego przeciwprostokątna jest średnicą tego okręgu, połowa przeciwprostokątnej tego trójkąta jest promieniem tego okręgu.', 1, '2021-01-04 11:48:54', 0, 66, 28800),
(145, 'Jeżeli okręgi są rozłączne zewnętrznie to odległość ich środków od siebie jest:', '| S<sub>1</sub>S<sub>2</sub> | > R+r', 1, '2021-01-04 11:49:05', 0, 66, 28800),
(146, 'W Okręgach przecinających się w 2 punktach, odległość środków znajduje się w zakresie:', '| R - r | < | S<sub>1</sub>S<sub>2</sub> | < R+r', 1, '2021-01-04 11:49:14', 0, 66, 28800),
(147, 'Jeżeli okręgi są rozłączne wewnętrznie to odległość ich środków od siebie jest:', '| S<sub>1</sub>S<sub>2</sub> | < | R-r |', 1, '2021-01-04 11:49:22', 0, 66, 28800),
(148, 'Pole trójkąta podobnego liczymy jako:', 'Pole trójkąta podobnego * skala podobieństwa podniesiona do kwadratu: k<sup>2</sup>', 1, '2021-01-04 11:49:41', 0, 66, 28800),
(149, 'Jeśli jest podana informacja na ile równych łuków podzielony jest okrąg to wiemy, że:', 'Kąt środkowy tych łuków to 360<sup>o</sup> / ilość łuków. Natomiast kąt wpisany to Kąt środkowy / 2', 1, '2021-01-04 11:50:05', 0, 66, 28800),
(150, 'Kąt wpisany oparty na średnicy ma miarę:', '90<sup>o</sup>', 1, '2021-01-04 11:50:11', 0, 66, 57600),
(151, 'Dana jest prosta AB oraz punkty C oraz D. Wówczas jeśli okrąg jest opisany na trójkącie ABC jest styczny do prostej AD, to:', 'Kąty BAD i BCA są równej miary', 1, '2021-01-04 11:51:46', 0, 66, 28800),
(152, 'Jeśli okręgi są styczne zewnętrznie to odległość ich środków jest równa:', '| S<sub>1</sub>S<sub>2</sub> | = R+r', 1, '2021-01-04 11:52:32', 0, 66, 28800),
(153, 'Promień okręgu stycznego do prostej, styka się z punktem stycznym pod kontem:', '90<sup>o</sup>', 1, '2021-01-04 11:52:38', 0, 66, 28800),
(154, 'Dwie proste styczne do okręgu wychodzące z tego samego punktu mają taką zależność:', 'Ich długości od Punktu stycznego do punktu z których wychodzą te styczne są takie same a więc: |PA| = |PB|', 1, '2021-01-04 11:52:52', 0, 66, 28800),
(155, 'Trójkąty przystające to:', 'trójkąty podobne w skali k = 1, a więc identyczne trójkąty', 1, '2021-01-04 11:52:58', 0, 66, 57600),
(156, 'Czworokąt wypukły ABCD, którego można opisać na okręgu wyróżnia się tą zależnością:', 'Suma długości boków |AB| + |CD| jest równa sumie długości boków |BC| + |AD|', 1, '2021-01-04 11:53:19', 0, 66, 28800),
(157, 'Jeśli okręgi są styczne wewnętrznie to odległość ich środków jest równa:', '| S<sub>1</sub>S<sub>2</sub> | = | R-r |', 1, '2021-01-04 11:53:29', 0, 66, 28800),
(158, 'Należy zwracać uwagę na położenie kątów oraz boków w trójkątach podobnych by:', 'Porównywać ze sobą odpowiednie boki, aby obliczyć długość niewiadomych boków', 1, '2021-01-04 11:53:42', 0, 66, 28800),
(159, 'Częstym zadaniem jest uzasadnienie podobieństwa mniejszych trójkątów wewnątrz większego trójkąta oraz obliczenie przy pomocy tych informacji skali oraz pól', '', 1, '2021-01-04 11:53:48', 1, 66, 28800),
(160, 'Twierdzenie talesa mówi, że: ', 'c/d = a/b\nc/a = d/b\nc/c+d = a/a+b\na/e = a+b/f\nZależności w trójkącie, gdzie mamy dwie proste równoległe do siebie', 1, '2021-01-04 11:54:02', 0, 66, 28800),
(161, 'Aby sinα był ujemny:', 'kąt α musi być rozwarty', 1, '2021-01-04 11:54:11', 0, 69, 28800),
(162, 'Dla konta o mierze mniejszej niż 90 cosα\nobliczymy jako:', 'Przyprostokątna przy kącie α / Przeciwprostokątna', 1, '2021-01-04 11:54:31', 0, 69, 28800),
(163, 'tangens α to inaczej:', 'sinα / cosα', 1, '2021-01-04 11:54:35', 0, 69, 28800),
(164, 'Dla konta o mierze mniejszej niż 90 tgα\nobliczymy jako:', 'Przyprostokątna na przeciwko kąta α / Przyprostokątna przy kącie α', 1, '2021-01-04 11:57:50', 0, 69, 21600),
(165, 'W wzorach redukcyjnych zamiana sinus na cosinus, cosinus na sinus, tangens na cotangens oraz cotangens na tangens zachodzi kiedy:', 'W wzorach redukcyjnych używamy 90<sup>o</sup> lub 270<sup>o</sup>', 1, '2021-01-04 11:57:56', 0, 69, 21600),
(166, 'Wzór na pole trójkąta, wykorzystujący sin kąta α oraz długość boków przyległych do konta α:', 'P = 1/2 * ab * sinα', 1, '2021-01-04 11:58:11', 0, 69, 21600),
(167, 'tgα można obliczyć za pomocą sinα oraz cosα dzieląc sinα / cosα', '', 2, '2021-01-04 11:58:16', 1, 69, 28800),
(168, 'Jedynka trygonometryczna - sin<sup>2</sup>α + cos<sup>2</sup>α = 1', '', 1, '2021-01-04 11:58:28', 1, 69, 21600),
(169, 'Dla kąta o mierze mniejszej niż 90<sup>o</sup> sinα tego konta obliczymy jako:', 'Przyprostokątna przeciwległa do tego konta / przeciwprostokątną', 1, '2021-01-04 11:58:44', 0, 69, 28800),
(170, 'Wzór na pole rombu, wykorzystujący funkcję trygonometryczną:', 'P = a<sup>2</sup> * sinα', 1, '2021-01-04 11:58:53', 0, 69, 28800),
(171, 'We wzorach redukcyjnych zmiana znaku zachodzi kiedy:', 'Pomiędzy funkcjami trygonometrycznymi w różnych ćwiartkach istnieje różnica znaku', 1, '2021-01-04 11:59:23', 0, 69, 28800),
(172, 'Wzory na sin, cos, tg kąta α na wykresie x, y :', 'sinα = y / r       cosα = x / r        tgα = y / x', 1, '2021-01-04 11:59:55', 0, 69, 28800),
(173, 'Rymowanka dotycząca znaków funkcji trygonometrycznych:', 'W pierwszej ćwiartce wszystkie są dodatnie, w drugiej tylko sinus, w trzeciej tangens i cotangens, a w czwartej cosinus', 1, '2021-01-04 12:00:04', 0, 69, 28800),
(175, 'Wielomian W(x) jest podzielny przez dwumian (x - a) wtedy i tylko wtedy, gdy W(a) = 0, dlatego, że:', 'pod x podstawiamy a, w równości W(x) = Q(x)(x - a) + R(x), np:\nW(x) = 6x3 + 3x2 - 5x + p\nDwumian: x - 1\n\n0 = W(1) = 6 + 3 - 5 + p  ⇒  p = -4', 1, '2021-01-04 12:00:09', 0, 72, 28800),
(176, 'Odchylenie standardowe to:', 'Średnia różnic pomiędzy wariancjami zbioru wzór: a - średnia zbioru x<sub>1</sub>, x<sub>2</sub>, x<sub>3</sub> - elementy zbioru. \n√( ( x<sub>1</sub> - a )<sup>2</sup> + ( x<sub>2</sub> - a )<sup>2</sup> + ( x<sub>3</sub> - a )<sup>2</sup> ) / 3 - dzielimy przez ilość elementów zbioru', 1, '2021-01-04 12:01:57', 0, 67, 28800),
(177, 'Jeśli proszą nas o kwadrat odchylenia standardowego to:', 'Liczymy odchylenie standardowe ale bez pierwiastka', 1, '2021-01-04 12:02:00', 0, 67, 28800),
(178, 'Jeśli : Δ < 0', 'Równanie kwadratowe nie ma rozwiązań, ponieważ √Δ jest sprzeczny - pierwiastek 2 stopnia z liczb ujemnych nie istnieje w zbiorze liczb ℝ', 1, '2021-01-04 11:37:06', 0, 62, 57600),
(179, 'Jeśli: Δ > 0', 'Równanie kwadratowe ma 2 pierwiastki ( rozwiązania ) - x<sub>1</sub> oraz x<sub>2</sub>, są one miejscami zerowymi równania', 1, '2021-01-04 11:37:12', 0, 62, 57600),
(180, 'Jeśli: Δ = 0', 'Równanie kwadratowe ma tylko jedno rozwiązanie, ponieważ współczynnik √Δ wzorów na x<sub>1</sub> oraz x<sub>2</sub> jest równy 0, a więc x<sub>1</sub> = x<sub>2</sub>', 1, '2021-01-04 11:37:19', 0, 62, 57600),
(181, 'x<sub>2</sub> - Drugie rozwiązanie równania', '( -b + √Δ ) / 2a', 1, '2021-01-04 11:37:29', 0, 62, 57600),
(182, 'Jeśli c = 0 ', 'Można wyłączyć x przed nawias i na tej podstawie wyliczyć x<sub>1</sub> = 0, x<sub>2</sub> = -b/a', 1, '2021-01-04 11:37:38', 0, 62, 57600),
(183, 'Jeśli b = 0 ∧ c/a <= 0', 'Równanie ma dwa rozwiązania \nx<sub>1</sub> = √-c/a,\n x<sub>2</sub> = -√-c/a ', 1, '2021-01-04 11:37:52', 0, 62, 57600),
(184, 'x<sub>1</sub> - Pierwsze rozwiązanie równania', '( -b - √Δ ) / 2a', 1, '2021-01-04 11:37:57', 0, 62, 57600),
(185, 'Δ Delta', 'b<sup>2</sup> - 4ac', 1, '2021-01-04 11:37:59', 0, 62, 57600),
(186, 'Jeśli b = 0 ∧ c/a > 0', 'Równanie nie ma rozwiązań ponieważ Δ < 0', 1, '2021-01-04 11:38:03', 0, 62, 57600),
(187, 'Przekształcanie równoważne:', 'x<sup>3</sup> - x<sup>2</sup> - 4x + 4 = x<sup>2</sup>( x - 1 ) - 4( x - 1 ) - Te same czynniki w nawiasach, a więc przekształcamy\n( x - 1 )( x<sup>2</sup> - 4 )', 1, '2021-01-04 11:38:35', 0, 62, 57600),
(188, 'Wzór na Objętość Walca:', 'P = Pp · h = πr2 · h', 1, '2021-01-04 12:02:14', 0, 68, 28800),
(189, 'Wzór na pole całkowite strożka:', 'P = ⅓ · Pp · H', 1, '2021-01-04 12:02:26', 0, 68, 28800),
(190, 'Objętość stożka:', 'V = ⅓ · πr2 · h, gdzie πr2 to pole podstawy', 1, '2021-01-04 12:02:40', 0, 68, 28800),
(191, 'Objętość graniastosłupa:', 'V = Pp · h - Pole podstawy razy wysokość', 1, '2021-01-04 12:02:46', 0, 68, 28800),
(192, 'Wzór na wysokość trójkąta równobocznego:', 'h = a√3 / 2', 1, '2021-01-04 12:02:55', 0, 68, 28800),
(193, 'Kąt nachylenia do płaszczyzny, musi być nachylony prosto do niej, a nie pod żadnym dziwnym dodatkowym nachyleniem', '', 1, '2021-01-04 12:02:58', 1, 68, 57600),
(194, 'Pole całkowite walca:', 'Pc = 2 · Pp + Pb = 2πr<sup>2</sup> + ( 2πr * h ) - powierzchnia boczna', 1, '2021-01-04 12:03:43', 0, 68, 28800),
(195, 'Wzór na objętość kuli:', 'V = ⁴⁄₃πr3', 1, '2021-01-04 12:03:51', 0, 68, 28800),
(196, 'Wzór na pole powierzchni kuli:', 'P = 4πr2', 1, '2021-01-04 12:03:59', 0, 68, 28800),
(197, 'Pole powierzchni ostrosłupa:', 'Pc = Pp + Pb - pole podstawy i pola wszystkich ścian', 1, '2021-01-04 12:04:14', 0, 68, 28800),
(198, 'Wzór na n-ty wyraz ciągu, znając wartość jednego z elementów ciągu oraz iloraz ciągu q:', 'a<sub>n</sub> = a<sub>?</sub> * q<sup>n</sup><sup>-</sup><sup>?</sup> - przykład: a<sub>9</sub> = a<sub>3</sub> * q<sup>9</sup><sup>-</sup><sup>3</sup>', 2, '2021-01-04 12:05:00', 0, 71, 28800),
(199, 'Wzór na jeden z 3 kolejnych elementów ciągu geometrycznego:', 'a<sub>n</sub><sup>2</sup> = a<sub>n</sub><sub>-</sub><sub>1</sub> * a<sub>n</sub><sub>+</sub><sub>1</sub>', 1, '2021-01-04 12:05:13', 0, 71, 28800),
(200, 'Sumę dowolnej liczby wyrazów w ciągu arytmetycznym możemy obliczyć za pomocą wzorów:', 'S<sub>n</sub> = ( ( a<sub>1</sub> + a<sub>n</sub> ) / 2 ) * n - średnia arytmetyczna wszystkich wyrazów razy ilość tych wyrazów, lub: S<sub>n</sub> = ( ( 2a<sub>1</sub> + ( n - 1 ) * r ) / 2 ) * n', 2, '2021-01-04 12:06:02', 0, 71, 28800),
(201, 'Wzór na sumę elementów w ciągu geometrycznym:', 'S<sub>n</sub> = a<sub>1</sub> * ( ( 1 - q<sup>n</sup> ) / ( 1 - q ) )', 2, '2021-01-04 12:06:31', 0, 71, 28800),
(202, 'wzór ogólny ciągu arytmetycznego liczymy tak:', 'a<sub>n</sub> = a<sub>1</sub> + ( n - 1 ) * r', 1, '2021-01-04 12:06:53', 0, 71, 28800),
(203, 'Jeśli ciąg jest arytmetyczny to jeden z niewiadomych elementów ciągu można obliczyć w następujący sposób:', 'Obliczyć średnią arytmetyczną wyrazów skrajnych, a więc a<sub>n</sub><sub>-</sub><sub>1</sub> oraz a<sub>n</sub><sub>+</sub><sub>1</sub>, wynika to z tego, że różnica pomiędzy a<sub>n</sub> a wyrazami skrajnymi jest taka sama', 1, '2021-01-04 12:07:16', 0, 71, 28800),
(204, 'Wzór na n-ty wyraz ciągu geometrycznego:', 'a<sub>n</sub> = a<sub>1</sub> * q<sup>n</sup><sup>-</sup><sup>1</sup>', 2, '2021-01-04 12:07:24', 0, 71, 28800),
(205, 'Ciąg jest arytmetyczny gdy:', 'a<sub>n</sub> - a<sub>n</sub><sub>-</sub><sub>1</sub> daje stałą różnicę pomiędzy kolejnymi elementami ciągu', 2, '2021-01-04 12:07:29', 0, 71, 28800),
(206, 'Ciąg jest geometryczny jeżeli:', 'Iloraz q 2 kolejnych elementów ciągu jest liczbą stałą np. 2<sup>n</sup> / 2<sup>n</sup><sup>-</sup><sup>1</sup> = 2<sup>1</sup> = 2', 2, '2021-01-04 12:07:46', 0, 71, 28800),
(207, 'Obliczenie sumy ciągu arytmetycznego od wyrazu k-tego to n-tego:', 'S<sub>n</sub><sup>k</sup> = ( ( a<sub>k</sub> + a<sub>n</sub> ) / 2 ) * ( n - k + 1 ) - średnia arytmetyczna wyrazów skrajnych sumy razy różnica ich miejsc w ciągu + 1', 1, '2021-01-04 12:08:19', 0, 71, 28800),
(208, 'Wzór viete\'a na iloczyn pierwiastków:', 'x<sub>1</sub> * x<sub>2</sub> = c/a', 2, '2021-01-04 12:00:28', 0, 73, 16200),
(209, 'Rozwiązanie układu równań dwóch funkcji daje nam ich:', 'Punkty wspólne', 2, '2021-01-04 12:00:33', 0, 73, 16200),
(210, 'Wzór viete\'a na sumę pierwiastków:', 'x<sub>1</sub> + x<sub>2</sub> = -b/a', 2, '2021-01-04 12:00:39', 0, 73, 16200),
(211, 'Dziedzina wyrażenia wymiernego to:', 'Wszystkie x jakie możemy podstawić do wzoru funkcji. A więc np. Wszystkie x oprócz tych, które dają 0 w mianowniku, ponieważ nie można dzielić przez 0', 2, '2021-01-04 12:00:42', 0, 73, 28800),
(212, 'Wzory vieta umożliwiają znalezienie miejsc zerowych, wiedząc jakie znaki mają niewiadome, a więc:', ' 2 dodatnie dają dodatni wynik mnożenia oraz dodawania, 2 ujemne dają dodatni wynik mnożenia, ale ujemny dodawania. Przeciwne znaki dają ujemny wynik mnożenia.', 2, '2021-01-04 12:01:19', 0, 73, 28800);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `card_group`
--

CREATE TABLE `card_group` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `color` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `card_group`
--

INSERT INTO `card_group` (`id`, `name`, `amount`, `color`) VALUES
(4, 'KUTASY 12', 1, '#782201DF'),
(5, 'KUTASY 12', 0, '#782201DF'),
(55, 'Matematyka I', 9, '#86b715CF'),
(56, 'Matematyka II', 6, '#71a215CF'),
(57, 'Matematyka III', 4, '#71a215CF'),
(58, 'Matematyka IV', 3, '#c21965CF'),
(59, 'Matematyke - Geometria', 8, '#2898bdCF'),
(60, 'Geometria analityczna', 6, '#329dd2CF'),
(61, 'Nierówności kwadratowe', 6, '#75cd1dCF'),
(62, 'Równania kwadratowe', 11, '#339eccCF'),
(63, 'Funkcje', 14, '#d7d23cCF'),
(64, 'Przekształcanie funkcji', 6, '#dfd32aCF'),
(65, 'Rysowanie wykresu funkcji liniowej', 7, '#d4c81cCF'),
(66, 'Planimetria', 19, '#c00748CF'),
(67, 'Statystyka', 2, '#2876dcCF'),
(68, 'Stereometria', 10, '#5046ddCF'),
(69, 'Trygonometria', 13, '#3dd17dCF'),
(70, 'Wartości bezwzględne', 5, '#c21919CF'),
(71, 'Ciągi', 10, '#170887CF'),
(72, 'Wielomiany', 1, '#502020CF'),
(73, 'Wzory viete\'a, punkty wspólne', 0, '#491330CF');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `last_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `last_login`) VALUES
(1, 'ff', 'ff', '0000-00-00 00:00:00'),
(4, 'Janke', '$2y$10$EJQ9DyV1iGgLclZvAyhyj.lgCTQC7IrMgwjpahMuMYgQ0HbMcDPxG', '2021-03-13 19:23:19'),
(5, 'tester', '$2y$10$T7TZ3bnwZ2FKEP3jFGz.0e4kwACbnf9jcwbLeJKlazQ09O8nW322.', '2020-12-06 00:27:05'),
(6, 'tester2', '$2y$10$/T52ussCLpRZLw0PsfG34.mbtYcvavueU5cmOBKuFZ7qKPlcCE2Pu', '2020-12-06 00:27:33');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_has_card_group`
--

CREATE TABLE `user_has_card_group` (
  `user_id` int(11) NOT NULL,
  `card_group_id` int(11) NOT NULL,
  `position_y` int(2) NOT NULL,
  `position_x` int(2) DEFAULT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `user_has_card_group`
--

INSERT INTO `user_has_card_group` (`user_id`, `card_group_id`, `position_y`, `position_x`, `owner`) VALUES
(4, 55, 0, 0, 1),
(4, 56, 1, 0, 1),
(4, 57, 2, 0, 1),
(4, 58, 3, 0, 1),
(4, 59, 0, 1, 1),
(4, 60, 3, 1, 1),
(4, 61, 3, 3, 1),
(4, 62, 2, 1, 1),
(4, 63, 0, 2, 1),
(4, 64, 1, 2, 1),
(4, 65, 2, 2, 1),
(4, 66, 0, 3, 1),
(4, 67, 0, 4, 1),
(4, 68, 1, 4, 1),
(4, 69, 1, 3, 1),
(4, 70, 3, 2, 1),
(4, 71, 2, 4, 1),
(4, 72, 2, 3, 1),
(4, 73, 1, 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_has_friend`
--

CREATE TABLE `user_has_friend` (
  `users_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_card_card_group` (`card_group_id`);

--
-- Indeksy dla tabeli `card_group`
--
ALTER TABLE `card_group`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `user_has_card_group`
--
ALTER TABLE `user_has_card_group`
  ADD PRIMARY KEY (`user_id`,`card_group_id`),
  ADD KEY `fk_users_has_card_group_card_group1` (`card_group_id`);

--
-- Indeksy dla tabeli `user_has_friend`
--
ALTER TABLE `user_has_friend`
  ADD KEY `fk_user_has_friend_users1` (`users_id`),
  ADD KEY `fk_user_has_friend_users2` (`friend_id`);

--
-- AUTO_INCREMENT dla tabel zrzutów
--

--
-- AUTO_INCREMENT dla tabeli `card`
--
ALTER TABLE `card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

--
-- AUTO_INCREMENT dla tabeli `card_group`
--
ALTER TABLE `card_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `fk_card_card_group` FOREIGN KEY (`card_group_id`) REFERENCES `card_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `user_has_card_group`
--
ALTER TABLE `user_has_card_group`
  ADD CONSTRAINT `fk_users_has_card_group_card_group1` FOREIGN KEY (`card_group_id`) REFERENCES `card_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_card_group_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `user_has_friend`
--
ALTER TABLE `user_has_friend`
  ADD CONSTRAINT `fk_user_has_friend_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_has_friend_users2` FOREIGN KEY (`friend_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
