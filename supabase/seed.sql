-- ============================================================================
-- Obscura — Seed Data
-- ============================================================================
-- Ejecutable directamente en el SQL Editor de Supabase.
-- UUIDs hardcodeados fijos para permitir referencias cruzadas entre tablas.
-- Orden de INSERT respeta las foreign keys del schema.
--
-- Convención de UUIDs:
--   categories         -> 11111111-...-1111111111NN
--   countries          -> 22222222-...-2222222222NN
--   tags               -> 33333333-...-3333333333NN
--   mysteries          -> 44444444-...-4444444444NN
-- ============================================================================

-- ─── SECCIÓN 1 — CATEGORÍAS (10) ────────────────────────────────────────────
INSERT INTO categories (id, name, slug, description, icon, color) VALUES
  ('11111111-1111-1111-1111-111111111101', 'Cultos y Sectas', 'cultos-sectas', 'Organizaciones secretas con rituales perturbadores', 'skull', '#cc0000'),
  ('11111111-1111-1111-1111-111111111102', 'Asesinatos Sin Resolver', 'asesinatos-sin-resolver', 'Crímenes que la justicia nunca pudo cerrar', 'eye', '#8b0000'),
  ('11111111-1111-1111-1111-111111111103', 'Fenómenos Paranormales', 'fenomenos-paranormales', 'Sucesos que desafían toda explicación científica', 'ghost', '#444444'),
  ('11111111-1111-1111-1111-111111111104', 'Entidades y Criaturas', 'entidades-criaturas', 'Seres documentados en testimonios reales', 'triangle-alert', '#7a0000'),
  ('11111111-1111-1111-1111-111111111105', 'Rituales Ocultistas', 'rituales-ocultistas', 'Prácticas esotéricas con consecuencias reales', 'flame', '#cc0000'),
  ('11111111-1111-1111-1111-111111111106', 'Desapariciones Inexplicables', 'desapariciones-inexplicables', 'Personas que se esfumaron sin dejar rastro', 'search', '#b8860b'),
  ('11111111-1111-1111-1111-111111111107', 'Lugares Malditos', 'lugares-malditos', 'Ubicaciones con historias de horror documentadas', 'map-pin', '#444444'),
  ('11111111-1111-1111-1111-111111111108', 'Experimentos Prohibidos', 'experimentos-prohibidos', 'Proyectos científicos que cruzaron toda línea ética', 'flask', '#8b0000'),
  ('11111111-1111-1111-1111-111111111109', 'Mensajes Cifrados y Conspiraciones', 'mensajes-cifrados', 'Códigos, comunicaciones ocultas y tramas encubiertas', 'lock', '#b8860b'),
  ('11111111-1111-1111-1111-111111111110', 'Folklore Oscuro', 'folklore-oscuro', 'Leyendas y mitos con raíces en hechos reales', 'book-open', '#7a0000');

-- ─── SECCIÓN 2 — PAÍSES (7) ─────────────────────────────────────────────────
INSERT INTO countries (id, name, code, flag_emoji, continent) VALUES
  ('22222222-2222-2222-2222-222222222201', 'Rusia', 'RU', '🇷🇺', 'Europe'),
  ('22222222-2222-2222-2222-222222222202', 'España', 'ES', '🇪🇸', 'Europe'),
  ('22222222-2222-2222-2222-222222222203', 'Malasia', 'MY', '🇲🇾', 'Asia'),
  ('22222222-2222-2222-2222-222222222204', 'Estados Unidos', 'US', '🇺🇸', 'North America'),
  ('22222222-2222-2222-2222-222222222205', 'Reino Unido', 'GB', '🇬🇧', 'Europe'),
  ('22222222-2222-2222-2222-222222222206', 'Alemania', 'DE', '🇩🇪', 'Europe'),
  ('22222222-2222-2222-2222-222222222207', 'Guyana', 'GY', '🇬🇾', 'South America');

-- ─── SECCIÓN 3 — TAGS (15) ──────────────────────────────────────────────────
INSERT INTO tags (id, name, slug) VALUES
  ('33333333-3333-3333-3333-333333333301', 'Guerra Fría', 'guerra-fria'),
  ('33333333-3333-3333-3333-333333333302', 'CIA', 'cia'),
  ('33333333-3333-3333-3333-333333333303', 'OVNI', 'ovni'),
  ('33333333-3333-3333-3333-333333333304', 'Culto', 'culto'),
  ('33333333-3333-3333-3333-333333333305', 'Desaparición', 'desaparicion'),
  ('33333333-3333-3333-3333-333333333306', 'Radiación', 'radiacion'),
  ('33333333-3333-3333-3333-333333333307', 'Manuscrito', 'manuscrito'),
  ('33333333-3333-3333-3333-333333333308', 'Asesino Serial', 'asesino-serial'),
  ('33333333-3333-3333-3333-333333333309', 'Experimento', 'experimento'),
  ('33333333-3333-3333-3333-333333333310', 'Gobierno', 'gobierno'),
  ('33333333-3333-3333-3333-333333333311', 'Conspiración', 'conspiracion'),
  ('33333333-3333-3333-3333-333333333312', 'Paranormal', 'paranormal'),
  ('33333333-3333-3333-3333-333333333313', 'Testigos', 'testigos'),
  ('33333333-3333-3333-3333-333333333314', 'Archivos Clasificados', 'archivos-clasificados'),
  ('33333333-3333-3333-3333-333333333315', 'URSS', 'urss');

-- ─── SECCIÓN 4 — MYSTERIES (10) ─────────────────────────────────────────────
INSERT INTO mysteries (
  id, slug, title, summary, description, status, classification_level,
  image_url, latitude, longitude, year_occurred, views_count,
  category_id, country_id, published_at
) VALUES
  (
    '44444444-4444-4444-4444-444444444401',
    'masacre-paso-dyatlov',
    'La Masacre del Paso Dyatlov',
    'Nueve excursionistas experimentados murieron en circunstancias imposibles en los Urales soviéticos. Sus cuerpos aparecieron semidesnudos, con heridas internas inexplicables y rastros de radiación. Más de seis décadas después, nadie sabe qué los hizo huir hacia la muerte en la noche helada.',
    E'En la noche del 1 de febrero de 1959, nueve estudiantes del Instituto Politécnico de los Urales acamparon en la ladera del Kholat Syakhl, una montaña cuyo nombre en mansi significa "Montaña de los Muertos". Eran montañistas curtidos, preparados para condiciones extremas. Ninguno volvería con vida.\n\nCuando los rescatistas hallaron la tienda semanas después, descubrieron que había sido cortada desde adentro. Los excursionistas habían huido al exterior con temperaturas de -30 °C, muchos descalzos y a medio vestir. Los primeros cuerpos aparecieron cerca de los restos de una fogata, bajo un cedro; otros, dispersos en dirección al campamento, como si hubiesen intentado regresar.\n\nLa autopsia profundizó el horror. Cuatro de las víctimas presentaban fracturas masivas de cráneo y tórax, comparables a las de un accidente automovilístico, pero sin heridas externas. A una mujer le faltaban la lengua y los ojos. En la ropa de varios se detectaron niveles anómalos de radiación. La investigación soviética se cerró con una frase tan vaga como inquietante: una "fuerza natural irresistible".\n\nDurante décadas, los archivos permanecieron clasificados y el paso fue cerrado a excursionistas. Las teorías abarcan desde avalanchas y fenómenos meteorológicos hasta pruebas militares secretas y encuentros con lo desconocido. En 2019 Rusia reabrió el caso, pero las preguntas esenciales —qué obligó a nueve personas racionales a correr hacia su muerte— siguen sin respuesta.',
    'published', 'extreme', 'https://images.unsplash.com/photo-1551582045-6ec9c11d8697?w=1200&q=80', 61.7539, 59.4562, 1959, 847293,
    '11111111-1111-1111-1111-111111111103', '22222222-2222-2222-2222-222222222201', now()
  ),
  (
    '44444444-4444-4444-4444-444444444402',
    'manuscrito-voynich',
    'El Manuscrito Voynich',
    'Un libro de más de seiscientos años escrito en un idioma que nadie ha podido leer. Sus páginas muestran plantas inexistentes, mujeres flotando en fluidos verdes y mapas astronómicos imposibles. Los mejores criptógrafos del mundo han fracasado ante él.',
    E'El Manuscrito Voynich es, posiblemente, el libro más misterioso jamás escrito. Compuesto por unas 240 páginas de vitela, fue datado por radiocarbono a principios del siglo XV. Su texto, escrito en un alfabeto desconocido bautizado como "voynichés", ha resistido todos los intentos de descifrado.\n\nLas ilustraciones solo aumentan el desconcierto. Secciones enteras muestran plantas que no corresponden a ninguna especie conocida, diagramas astronómicos con constelaciones inexistentes y figuras femeninas conectadas a una red de tuberías llenas de un líquido verdoso. Nada en él encaja con el conocimiento de su época.\n\nDurante la Segunda Guerra Mundial, los criptógrafos que rompieron los códigos nazis y japoneses se enfrentaron al manuscrito y se rindieron. Los análisis lingüísticos modernos revelan que el texto sigue patrones estadísticos propios de un idioma real —no de un galimatías al azar—, lo que descarta que sea un simple fraude sin sentido.\n\nLas hipótesis se multiplican: una lengua perdida, un código cifrado, una obra de un alquimista, incluso un elaborado engaño medieval. Hoy custodiado en la Biblioteca Beinecke de Yale, el Voynich sigue desafiando a la inteligencia artificial y a los académicos. Seis siglos después, su secreto permanece intacto.',
    'published', 'disturbing', 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1200&q=80', 41.6521, -4.7286, 1404, 623847,
    '11111111-1111-1111-1111-111111111109', '22222222-2222-2222-2222-222222222202', now()
  ),
  (
    '44444444-4444-4444-4444-444444444403',
    'desaparicion-mh370',
    'La Desaparición del Vuelo MH370',
    'Un Boeing 777 con 239 personas a bordo se desvaneció del cielo en pleno siglo XXI. Cambió de rumbo deliberadamente, voló durante horas hacia el océano más remoto del planeta y nunca volvió a aparecer. Es la mayor incógnita de la aviación moderna.',
    E'El 8 de marzo de 2014, el vuelo MH370 de Malaysia Airlines despegó de Kuala Lumpur rumbo a Pekín con 239 personas a bordo. Treinta y ocho minutos después, en pleno traspaso entre el control aéreo malayo y el vietnamita, el copiloto pronunció su última frase: "Buenas noches, Malaysia tres siete cero". Luego, silencio.\n\nLos transpondedores se apagaron. El avión, en lugar de continuar hacia el norte, giró bruscamente hacia el oeste, sobrevoló la península malaya y se internó en el océano Índico meridional, una de las zonas más aisladas e inexploradas del planeta. Los datos satelitales de Inmarsat trazaron un "arco" final, pero ninguna posición exacta.\n\nLa búsqueda se convirtió en la más cara y extensa de la historia de la aviación, rastreando 120.000 km² de fondo marino sin hallar el fuselaje. Solo algunos fragmentos —un flaperón, partes de ala— aparecieron años después en costas africanas, confirmando que el avión efectivamente cayó al mar.\n\nLas teorías oscilan entre el suicidio premeditado del piloto, un secuestro, un incendio a bordo y conspiraciones más oscuras. Cada hipótesis choca con algún dato imposible de explicar. Una década después, la pregunta sigue intacta: ¿cómo desaparece por completo un avión de pasajeros en la era de los satélites?',
    'published', 'extreme', 'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=1200&q=80', 6.9271, 79.8612, 2014, 923847,
    '11111111-1111-1111-1111-111111111106', '22222222-2222-2222-2222-222222222203', now()
  ),
  (
    '44444444-4444-4444-4444-444444444404',
    'experimento-mk-ultra',
    'El Experimento MK-Ultra',
    'Durante décadas, la CIA experimentó con la mente humana en ciudadanos que jamás dieron su consentimiento. Drogas, electroshocks, tortura y control mental disfrazados de investigación científica. La mayoría de los archivos fueron destruidos antes de salir a la luz.',
    E'MK-Ultra fue un programa secreto de la CIA iniciado en 1953 con un objetivo escalofriante: dominar la mente humana. En el clima paranoico de la Guerra Fría, la agencia buscaba métodos de interrogatorio, control de la conducta y "lavado de cerebro" que superaran a los del bloque soviético.\n\nDurante más de veinte años, científicos administraron LSD y otras sustancias a ciudadanos sin su conocimiento ni consentimiento. Hubo sesiones de electroshock prolongado, privación sensorial, hipnosis y aislamiento extremo. Las víctimas incluían pacientes psiquiátricos, presos, soldados y personas comunes captadas en bares y prostíbulos financiados por la propia agencia.\n\nEl programa operó en al menos 80 instituciones, entre universidades, hospitales y prisiones, muchas veces a través de fundaciones pantalla. Algunas víctimas sufrieron daños permanentes; otras murieron en circunstancias nunca esclarecidas, como el científico Frank Olson, que cayó de la ventana de un hotel tras ser dosificado en secreto.\n\nEn 1973, ante la inminencia de investigaciones, el director de la CIA ordenó destruir la mayoría de los expedientes. Solo sobrevivieron porque algunos documentos financieros quedaron archivados por error. Lo que hoy se conoce es apenas una fracción. El alcance real de MK-Ultra —y cuántas mentes fueron rotas en su nombre— permanece clasificado para siempre.',
    'published', 'classified', 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?w=1200&q=80', 38.8951, -77.0364, 1953, 712938,
    '11111111-1111-1111-1111-111111111108', '22222222-2222-2222-2222-222222222204', now()
  ),
  (
    '44444444-4444-4444-4444-444444444405',
    'asesino-zodiaco',
    'El Asesino del Zodíaco',
    'Un asesino que se burlaba de la policía con cartas cifradas firmadas con un símbolo siniestro. Mató al menos a cinco personas en California y prometió muchas más. Su identidad nunca fue revelada y sus códigos siguen, en parte, sin resolver.',
    E'A finales de los años sesenta, el norte de California fue aterrorizado por un asesino que no buscaba ocultarse, sino ser célebre. Atacaba a parejas jóvenes en lugares apartados y luego enviaba cartas a la prensa, exigiendo que se publicaran o amenazaba con más muertes. Firmaba con un círculo atravesado por una cruz: el símbolo del Zodíaco.\n\nSe le atribuyen con certeza cinco asesinatos entre 1968 y 1969, aunque él se jactaba de haber matado a 37 personas. Su frialdad era metódica: en una ocasión llamó a la policía para anunciar sus propios crímenes; en otra, se acercó a las víctimas con una capucha de verdugo y un símbolo cosido en el pecho.\n\nLo que volvió legendario al caso fueron sus criptogramas. Envió cuatro mensajes cifrados; uno de ellos, descifrado por un matrimonio de profesores, contenía una declaración delirante sobre cómo matar le proporcionaba esclavos para la otra vida. Otro, el "Z340", resistió medio siglo hasta ser resuelto por aficionados en 2020. Dos cifrados siguen sin solución.\n\nDecenas de sospechosos fueron investigados a lo largo de las décadas, pero ninguno pudo ser confirmado. El Zodíaco simplemente dejó de escribir y se desvaneció. Su rostro, su nombre y su destino final continúan siendo uno de los enigmas criminales más perturbadores de Estados Unidos.',
    'published', 'extreme', 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=1200&q=80', 37.7749, -122.4194, 1968, 534721,
    '11111111-1111-1111-1111-111111111102', '22222222-2222-2222-2222-222222222204', now()
  ),
  (
    '44444444-4444-4444-4444-444444444406',
    'incidente-roswell',
    'El Incidente de Roswell',
    'Algo se estrelló en el desierto de Nuevo México en 1947. El ejército primero anunció la recuperación de un "disco volador" y luego se retractó. Lo que realmente cayó esa noche se convirtió en la piedra angular de toda la mitología OVNI moderna.',
    E'En julio de 1947, un ranchero llamado Mac Brazel encontró extraños restos esparcidos en su propiedad cerca de Roswell, Nuevo México: material metálico ligero que recuperaba su forma al doblarse y vigas con inscripciones desconocidas. La base aérea local emitió un comunicado que conmocionó al país: habían recuperado un "disco volador".\n\nHoras después, el ejército se retractó abruptamente. Lo recuperado, dijeron, no era más que un globo meteorológico. Las fotografías oficiales mostraron a un oficial sosteniendo restos de papel aluminio y madera balsa. El asunto pareció cerrarse tan rápido como había explotado.\n\nDécadas más tarde, testigos comenzaron a hablar. Hablaban de cuerpos pequeños con cabezas grandes, de cordones militares para silenciar a la población, de hangares secretos y autopsias clandestinas. En los años noventa, el Gobierno estadounidense ofreció una nueva explicación: los restos pertenecían al Proyecto Mogul, globos espía diseñados para detectar pruebas nucleares soviéticas.\n\nPero para entonces, Roswell ya se había convertido en algo más grande que cualquier explicación oficial. El caso fundó la cultura OVNI moderna, el mito del Área 51 y la sospecha permanente de que los gobiernos ocultan la verdad sobre visitantes de otros mundos. Lo que cayó en el desierto sigue dividiendo a escépticos y creyentes.',
    'published', 'classified', 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=1200&q=80', 33.3943, -104.5230, 1947, 891234,
    '11111111-1111-1111-1111-111111111103', '22222222-2222-2222-2222-222222222204', now()
  ),
  (
    '44444444-4444-4444-4444-444444444407',
    'masacre-jonestown',
    'La Masacre de Jonestown',
    'Más de novecientas personas murieron en un solo día en la selva de Guyana, envenenadas por orden de su líder mesiánico. Lo llamaron "suicidio revolucionario", pero entre los muertos había cientos de niños. Es uno de los actos de muerte masiva más escalofriantes de la historia moderna.',
    E'El Templo del Pueblo comenzó como un movimiento religioso progresista en Estados Unidos, liderado por el carismático Jim Jones. Predicaba la igualdad racial y la justicia social, atrayendo a miles de seguidores. Pero detrás de su discurso se escondía un control psicológico cada vez más totalitario.\n\nHuyendo del escrutinio mediático, Jones trasladó a su congregación a la selva de Guyana, donde fundó una comuna aislada: Jonestown. Allí, lejos del mundo, el paraíso prometido se transformó en una prisión. Los miembros entregaban sus pasaportes y bienes, trabajaban en condiciones extremas y eran sometidos a "noches blancas", simulacros de suicidio colectivo para medir su lealtad.\n\nEl 18 de noviembre de 1978, el congresista Leo Ryan viajó a investigar denuncias de abusos. Cuando intentaba marcharse con varios desertores, fue asesinado junto a parte de su comitiva en la pista de aterrizaje. Jones sabía que el fin había llegado.\n\nEsa misma tarde ordenó el "suicidio revolucionario". Se preparó ponche con cianuro; a los niños se les administró primero, con jeringas. Murieron 909 personas, más de 300 de ellas menores de edad. Jones apareció muerto de un disparo. Las grabaciones de audio de aquellas últimas horas, conocidas como "la cinta de la muerte", siguen siendo testimonio insoportable de hasta dónde puede llegar el poder de un solo hombre sobre la mente humana.',
    'published', 'extreme', 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=1200&q=80', 7.3697, -59.5278, 1978, 445678,
    '11111111-1111-1111-1111-111111111101', '22222222-2222-2222-2222-222222222207', now()
  ),
  (
    '44444444-4444-4444-4444-444444444408',
    'caras-belmez',
    'Las Caras de Bélmez',
    'En una humilde casa andaluza, los rostros comenzaron a aparecer solos sobre el suelo de la cocina. Surgían, cambiaban de expresión y se desvanecían. Durante décadas, el fenómeno desafió a científicos, sacerdotes y parapsicólogos por igual.',
    E'En agosto de 1971, en el pueblo de Bélmez de la Moraleda, Jaén, María Gómez Cámara vio formarse una mancha sobre el suelo de cemento de su cocina. La mancha tomó la forma de un rostro humano de expresión angustiada. Aterrada, su familia picó el suelo y lo cubrió de nuevo. Días después, otra cara emergió en el mismo lugar.\n\nEl fenómeno se repitió durante años. Aparecían rostros de distintos tamaños y gestos —ancianos, mujeres, figuras atormentadas— que parecían cambiar de expresión con el tiempo. La casa se convirtió en un destino de peregrinación y atrajo a periodistas, investigadores y curiosos de toda Europa.\n\nLos parapsicólogos hablaron de "teleplastias", impresiones psíquicas grabadas en la materia por la mente de María. Se especuló con que la casa estaba construida sobre un antiguo cementerio, y de hecho se hallaron restos humanos al excavar. Los escépticos, en cambio, sostuvieron que los rostros eran pintados con productos químicos, señalando análisis que detectaron pigmentos.\n\nNi unos ni otros lograron pruebas definitivas. Tras la muerte de María Gómez en 2004, algunos afirmaron que las caras siguieron apareciendo; otros, que el fenómeno cesó. Las Caras de Bélmez quedaron como uno de los casos paranormales más documentados —y más discutidos— de la historia de España.',
    'published', 'disturbing', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80', 37.9922, -4.0153, 1971, 234567,
    '11111111-1111-1111-1111-111111111107', '22222222-2222-2222-2222-222222222202', now()
  ),
  (
    '44444444-4444-4444-4444-444444444409',
    'poltergeist-enfield',
    'El Poltergeist de Enfield',
    'Durante más de un año, una familia del norte de Londres convivió con golpes, muebles que volaban y una voz gutural que hablaba a través de una niña de once años. Decenas de testigos lo presenciaron. Sigue siendo el caso de poltergeist mejor documentado de la historia.',
    E'En agosto de 1977, en una modesta casa de Enfield, al norte de Londres, la familia Hodgson comenzó a vivir una pesadilla. Todo empezó con golpes en las paredes y una cómoda que se desplazó sola por el dormitorio de las niñas. Pronto, los fenómenos se intensificaron de forma alarmante.\n\nEl epicentro parecía ser Janet, de once años. A su alrededor, los objetos volaban, las camas se sacudían y se escuchaban estruendos imposibles. Pero lo más perturbador fue una voz: grave, ronca, masculina, que salía de la garganta de la niña y afirmaba ser el espíritu de Bill Wilkins, un anciano que había muerto en esa casa años atrás. Detalles de su muerte, desconocidos para la familia, fueron luego confirmados.\n\nEl caso atrajo a investigadores de la Society for Psychical Research, policías, periodistas y vecinos. Un agente firmó una declaración afirmando haber visto una silla moverse sola. Se grabaron cientos de horas de audio con los golpes y la voz. Fotografías capturaron a Janet aparentemente suspendida en el aire.\n\nLos escépticos sostuvieron que las niñas confesaron haber fingido "algunos" episodios para divertirse, aunque insistieron en que la mayoría eran reales. El debate nunca se cerró. El Poltergeist de Enfield, con su abrumadora cantidad de testigos y registros, permanece como el caso más estudiado —y más inquietante— de actividad paranormal documentada.',
    'published', 'disturbing', 'https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=1200&q=80', 51.6512, -0.0778, 1977, 312456,
    '11111111-1111-1111-1111-111111111103', '22222222-2222-2222-2222-222222222205', now()
  ),
  (
    '44444444-4444-4444-4444-444444444410',
    'batalla-aerea-nuremberg',
    'La Batalla Aérea de Núremberg',
    'Al amanecer de 1561, cientos de habitantes de Núremberg vieron el cielo llenarse de esferas, cruces y tubos que parecían combatir entre sí. Un grabado de la época lo documentó. ¿Fenómeno atmosférico, histeria colectiva o algo que el siglo XVI no podía nombrar?',
    E'El 14 de abril de 1561, los habitantes de Núremberg, en la actual Alemania, presenciaron un espectáculo celeste que los llenó de terror. Según el relato de la época, el amanecer fue interrumpido por cientos de objetos extraños: esferas, cilindros, cruces y formas similares a placas que surcaban el cielo en todas direcciones.\n\nUna noticia ilustrada, impresa por Hans Glaser, recogió el suceso en un célebre grabado xilográfico. En él se ven globos rojos, negros y azulados, tubos de los que parecían salir más esferas, y dos grandes objetos en forma de tubo. Los testigos describieron que los objetos parecían "luchar" entre sí durante aproximadamente una hora, antes de que muchos cayeran a tierra y se consumieran en humo.\n\nPara los hombres del siglo XVI, no había duda: era una señal de Dios, una advertencia divina ante los pecados de la humanidad. El cronista interpretó el evento como un llamado al arrepentimiento. En una época dominada por la religión y el miedo, el cielo se había convertido en un campo de batalla sobrenatural.\n\nSiglos después, el episodio fue rescatado por los investigadores de fenómenos OVNI como una de las primeras observaciones masivas de objetos no identificados. Los científicos, en cambio, lo atribuyen a un fenómeno óptico conocido como parhelio o "sol falso". Lo cierto es que cientos de personas vieron algo en el cielo de Núremberg aquella mañana, y el grabado que lo inmortalizó sigue alimentando el debate cinco siglos más tarde.',
    'published', 'disturbing', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=1200&q=80', 49.4521, 11.0767, 1561, 178934,
    '11111111-1111-1111-1111-111111111110', '22222222-2222-2222-2222-222222222206', now()
  );

-- ─── SECCIÓN 5 — TIMELINE EVENTS ────────────────────────────────────────────
INSERT INTO timeline_events (mystery_id, year, title, description, "order") VALUES
  -- Dyatlov
  ('44444444-4444-4444-4444-444444444401', 1959, 'Inicio de la expedición', 'El grupo liderado por Ígor Diatlov parte de Sverdlovsk rumbo a la montaña Otorten, en los Urales del norte.', 0),
  ('44444444-4444-4444-4444-444444444401', 1959, 'Última fotografía', 'El 1 de febrero el grupo monta su tienda en la ladera del Kholat Syakhl. Sus últimas fotos muestran a un grupo en buen ánimo.', 1),
  ('44444444-4444-4444-4444-444444444401', 1959, 'La huida nocturna', 'Esa noche, la tienda es cortada desde adentro y los nueve excursionistas escapan al frío extremo, descalzos y a medio vestir.', 2),
  ('44444444-4444-4444-4444-444444444401', 1959, 'Hallazgo de los cuerpos', 'Las cuadrillas de rescate encuentran los primeros cadáveres bajo un cedro. El resto aparece en los meses siguientes con heridas inexplicables.', 3),
  ('44444444-4444-4444-4444-444444444401', 2019, 'Reapertura del caso', 'Las autoridades rusas reabren la investigación y concluyen que una avalancha fue la causa, sin convencer a la opinión pública.', 4),
  -- Voynich
  ('44444444-4444-4444-4444-444444444402', 1404, 'Creación del manuscrito', 'La datación por radiocarbono sitúa la vitela del manuscrito a principios del siglo XV.', 0),
  ('44444444-4444-4444-4444-444444444402', 1666, 'La carta de Marci', 'El manuscrito es enviado al erudito jesuita Athanasius Kircher con la esperanza de que pueda descifrarlo. Fracasa.', 1),
  ('44444444-4444-4444-4444-444444444402', 1912, 'Wilfrid Voynich lo adquiere', 'El librero polaco Wilfrid Voynich compra el manuscrito en Italia y le da su nombre, iniciando su fama moderna.', 2),
  ('44444444-4444-4444-4444-444444444402', 1969, 'Llega a Yale', 'El manuscrito es donado a la Biblioteca Beinecke de la Universidad de Yale, donde se conserva hasta hoy.', 3),
  ('44444444-4444-4444-4444-444444444402', 2017, 'La IA fracasa', 'Sucesivos intentos con inteligencia artificial y análisis lingüístico no logran descifrar su contenido.', 4),
  -- MH370
  ('44444444-4444-4444-4444-444444444403', 2014, 'Despegue', 'El 8 de marzo, el MH370 despega de Kuala Lumpur rumbo a Pekín con 239 personas a bordo.', 0),
  ('44444444-4444-4444-4444-444444444403', 2014, 'Último contacto', 'A los 38 minutos de vuelo, el copiloto se despide del control aéreo. Segundos después se apagan los transpondedores.', 1),
  ('44444444-4444-4444-4444-444444444403', 2014, 'Giro inexplicable', 'El radar militar detecta que el avión gira al oeste y se interna en el océano Índico meridional.', 2),
  ('44444444-4444-4444-4444-444444444403', 2015, 'Primeros restos', 'Un flaperón del avión aparece en la isla de Reunión, confirmando que cayó al mar.', 3),
  ('44444444-4444-4444-4444-444444444403', 2017, 'Fin de la búsqueda', 'Tras rastrear 120.000 km² del fondo oceánico sin hallar el fuselaje, la búsqueda oficial se suspende.', 4),
  -- MK-Ultra
  ('44444444-4444-4444-4444-444444444404', 1953, 'Nace el programa', 'El director de la CIA Allen Dulles autoriza el proyecto MK-Ultra para investigar el control mental.', 0),
  ('44444444-4444-4444-4444-444444444404', 1953, 'Muerte de Frank Olson', 'El científico Frank Olson cae de la ventana de un hotel días después de ser dosificado con LSD sin saberlo.', 1),
  ('44444444-4444-4444-4444-444444444404', 1960, 'Operación Midnight Climax', 'La CIA monta casas seguras donde se droga en secreto a ciudadanos para observar los efectos.', 2),
  ('44444444-4444-4444-4444-444444444404', 1973, 'Destrucción de archivos', 'El director Richard Helms ordena destruir la mayoría de los expedientes del programa.', 3),
  ('44444444-4444-4444-4444-444444444404', 1977, 'Audiencias del Senado', 'Documentos financieros sobrevivientes salen a la luz y el Senado investiga los abusos de MK-Ultra.', 4),
  -- Zodíaco
  ('44444444-4444-4444-4444-444444444405', 1968, 'Primeros asesinatos', 'Una pareja de adolescentes es asesinada en Benicia, California, en el primer crimen atribuido al Zodíaco.', 0),
  ('44444444-4444-4444-4444-444444444405', 1969, 'Las primeras cartas', 'El asesino envía cartas cifradas a periódicos exigiendo su publicación bajo amenaza de más muertes.', 1),
  ('44444444-4444-4444-4444-444444444405', 1969, 'El criptograma resuelto', 'Un matrimonio de profesores descifra uno de los códigos, que contiene un mensaje delirante sobre la muerte.', 2),
  ('44444444-4444-4444-4444-444444444405', 1974, 'Última carta confirmada', 'El Zodíaco envía su última misiva verificada y luego desaparece sin dejar rastro.', 3),
  ('44444444-4444-4444-4444-444444444405', 2020, 'El Z340 descifrado', 'Un equipo internacional de aficionados resuelve el criptograma de 340 caracteres tras 51 años.', 4),
  -- Roswell
  ('44444444-4444-4444-4444-444444444406', 1947, 'El hallazgo', 'El ranchero Mac Brazel encuentra restos metálicos extraños esparcidos en su propiedad cerca de Roswell.', 0),
  ('44444444-4444-4444-4444-444444444406', 1947, '"Disco volador" recuperado', 'La base aérea de Roswell emite un comunicado anunciando la recuperación de un disco volador.', 1),
  ('44444444-4444-4444-4444-444444444406', 1947, 'La retractación', 'Horas después, el ejército corrige la versión: solo se trataba de un globo meteorológico.', 2),
  ('44444444-4444-4444-4444-444444444406', 1978, 'Resurge el caso', 'El testimonio del oficial Jesse Marcel reaviva la teoría de que se ocultó un objeto extraterrestre.', 3),
  ('44444444-4444-4444-4444-444444444406', 1994, 'El Proyecto Mogul', 'La Fuerza Aérea declara que los restos pertenecían a globos espía secretos para detectar pruebas nucleares.', 4),
  -- Jonestown
  ('44444444-4444-4444-4444-444444444407', 1955, 'Fundación del Templo', 'Jim Jones funda el Templo del Pueblo en Indiana, predicando la igualdad racial y la justicia social.', 0),
  ('44444444-4444-4444-4444-444444444407', 1974, 'Mudanza a Guyana', 'La congregación arrienda terreno en la selva guyanesa para construir la comuna de Jonestown.', 1),
  ('44444444-4444-4444-4444-444444444407', 1977, 'El éxodo masivo', 'Cientos de miembros se trasladan a Jonestown huyendo del escrutinio mediático en Estados Unidos.', 2),
  ('44444444-4444-4444-4444-444444444407', 1978, 'Asesinato de Leo Ryan', 'El congresista Leo Ryan es asesinado en la pista de aterrizaje al intentar partir con desertores.', 3),
  ('44444444-4444-4444-4444-444444444407', 1978, 'La masacre', 'El 18 de noviembre, 909 personas mueren envenenadas con cianuro por orden de Jones; más de 300 eran niños.', 4),
  -- Bélmez
  ('44444444-4444-4444-4444-444444444408', 1971, 'La primera cara', 'María Gómez Cámara descubre un rostro formándose solo en el suelo de cemento de su cocina.', 0),
  ('44444444-4444-4444-4444-444444444408', 1971, 'Excavación del suelo', 'La familia destruye el suelo y lo recubre, pero nuevos rostros vuelven a aparecer en el mismo lugar.', 1),
  ('44444444-4444-4444-4444-444444444408', 1972, 'Restos humanos', 'Al excavar más profundo se hallan huesos humanos, alimentando la teoría de un antiguo cementerio.', 2),
  ('44444444-4444-4444-4444-444444444408', 1972, 'Investigación parapsicológica', 'Investigadores documentan el fenómeno y proponen la teoría de las "teleplastias".', 3),
  ('44444444-4444-4444-4444-444444444408', 2004, 'Muerte de María', 'Tras la muerte de María Gómez, el debate sobre la autenticidad de las caras continúa sin resolverse.', 4),
  -- Enfield
  ('44444444-4444-4444-4444-444444444409', 1977, 'Comienzan los golpes', 'La familia Hodgson escucha golpes y ve muebles moverse solos en su casa de Enfield.', 0),
  ('44444444-4444-4444-4444-444444444409', 1977, 'Llegan los investigadores', 'La Society for Psychical Research envía investigadores que documentan los fenómenos durante meses.', 1),
  ('44444444-4444-4444-4444-444444444409', 1977, 'La voz de Bill', 'Una voz gutural masculina habla a través de Janet, afirmando ser el espíritu de un hombre muerto en la casa.', 2),
  ('44444444-4444-4444-4444-444444444409', 1978, 'Testimonios policiales', 'Un agente de policía firma una declaración tras presenciar el movimiento de una silla sin causa visible.', 3),
  ('44444444-4444-4444-4444-444444444409', 1979, 'Fin del fenómeno', 'La actividad disminuye gradualmente, dejando cientos de horas de grabaciones y testimonios sin explicación.', 4),
  -- Núremberg
  ('44444444-4444-4444-4444-444444444410', 1561, 'El amanecer extraño', 'El 14 de abril, los habitantes de Núremberg ven el cielo llenarse de esferas, cruces y tubos al amanecer.', 0),
  ('44444444-4444-4444-4444-444444444410', 1561, 'La "batalla" celeste', 'Los objetos parecen combatir entre sí durante cerca de una hora ante cientos de testigos aterrados.', 1),
  ('44444444-4444-4444-4444-444444444410', 1561, 'La caída', 'Muchos de los objetos parecen precipitarse a tierra y consumirse en humo a las afueras de la ciudad.', 2),
  ('44444444-4444-4444-4444-444444444410', 1561, 'El grabado de Glaser', 'Hans Glaser imprime una noticia ilustrada con un grabado xilográfico que inmortaliza el suceso.', 3),
  ('44444444-4444-4444-4444-444444444410', 1958, 'Interpretación moderna', 'El psicólogo Carl Jung incluye el episodio en su estudio sobre los "platillos voladores" como mito moderno.', 4);

-- ─── SECCIÓN 5 — THEORIES ───────────────────────────────────────────────────
INSERT INTO theories (mystery_id, title, description, credibility_score, source_url) VALUES
  -- Dyatlov
  ('44444444-4444-4444-4444-444444444401', 'Avalancha de placa retardada', 'Un estudio de 2021 modeló una pequeña avalancha de placa que explicaría las fracturas y la huida del grupo.', 72, 'https://www.nature.com/articles/s43247-020-00081-8'),
  ('44444444-4444-4444-4444-444444444401', 'Pruebas militares secretas', 'La radiación detectada y las luces vistas en la zona sugieren ensayos de armas soviéticas encubiertos.', 38, 'https://en.wikipedia.org/wiki/Dyatlov_Pass_incident'),
  ('44444444-4444-4444-4444-444444444401', 'Infrasonido del viento', 'Vientos catabáticos pudieron generar infrasonidos que provocaron pánico irracional en los excursionistas.', 45, 'https://en.wikipedia.org/wiki/Dyatlov_Pass_incident'),
  -- Voynich
  ('44444444-4444-4444-4444-444444444402', 'Lengua natural cifrada', 'Análisis estadísticos muestran patrones propios de un idioma real codificado mediante un sistema desconocido.', 55, 'https://www.jstor.org/stable/voynich'),
  ('44444444-4444-4444-4444-444444444402', 'Engaño medieval elaborado', 'Algunos sostienen que es un fraude sin contenido, creado para vender a coleccionistas crédulos.', 30, 'https://en.wikipedia.org/wiki/Voynich_manuscript'),
  ('44444444-4444-4444-4444-444444444402', 'Glosolalia o lengua inventada', 'Pudo ser escrito en una lengua artificial o por una mente en estado alterado, sin un código deliberado.', 28, 'https://www.beinecke.library.yale.edu/collections/highlights/voynich-manuscript'),
  -- MH370
  ('44444444-4444-4444-4444-444444444403', 'Acto deliberado del piloto', 'La trayectoria controlada y la desconexión de sistemas apuntan a una acción intencional del capitán.', 68, 'https://www.atsb.gov.au/mh370-pages/'),
  ('44444444-4444-4444-4444-444444444403', 'Incendio o despresurización', 'Un incendio a bordo pudo incapacitar a la tripulación, dejando el avión volando en piloto automático.', 42, 'https://en.wikipedia.org/wiki/Malaysia_Airlines_Flight_370'),
  ('44444444-4444-4444-4444-444444444403', 'Secuestro o interferencia externa', 'Teorías sostienen una intervención de terceros, aunque sin evidencia que respalde el escenario.', 18, 'https://en.wikipedia.org/wiki/Malaysia_Airlines_Flight_370'),
  -- MK-Ultra
  ('44444444-4444-4444-4444-444444444404', 'Programa de control mental real', 'Documentos desclasificados confirman experimentos sistemáticos con drogas y tortura sobre civiles.', 85, 'https://www.intelligence.senate.gov/sites/default/files/hearings/95mkultra.pdf'),
  ('44444444-4444-4444-4444-444444444404', 'Alcance subestimado', 'La destrucción de archivos oculta un programa mucho más amplio de lo que se reconoce oficialmente.', 60, 'https://www.cia.gov/readingroom/'),
  ('44444444-4444-4444-4444-444444444404', 'Conexión con asesinos programados', 'Algunos vinculan MK-Ultra con la creación de "asesinos durmientes", una hipótesis sin pruebas sólidas.', 15, 'https://en.wikipedia.org/wiki/Project_MKUltra'),
  -- Zodíaco
  ('44444444-4444-4444-4444-444444444405', 'Arthur Leigh Allen', 'El sospechoso más investigado; circunstancias y testimonios lo señalan, pero el ADN no lo confirmó.', 50, 'https://en.wikipedia.org/wiki/Zodiac_Killer'),
  ('44444444-4444-4444-4444-444444444405', 'Más víctimas de las confirmadas', 'El Zodíaco afirmó haber matado a 37 personas; varios crímenes sin resolver podrían atribuírsele.', 35, 'https://www.fbi.gov/history/famous-cases/zodiac-killer'),
  ('44444444-4444-4444-4444-444444444405', 'Identidad ya fallecida', 'El cese abrupto de las cartas sugiere que el asesino murió o fue encarcelado por otros delitos.', 40, 'https://en.wikipedia.org/wiki/Zodiac_Killer'),
  -- Roswell
  ('44444444-4444-4444-4444-444444444406', 'Globo del Proyecto Mogul', 'La explicación oficial: los restos pertenecían a globos espía secretos para detectar pruebas nucleares.', 70, 'https://www.archives.gov/foia/ufos'),
  ('44444444-4444-4444-4444-444444444406', 'Nave extraterrestre', 'Testigos describen materiales imposibles y cuerpos no humanos, sosteniendo el origen alienígena.', 32, 'https://en.wikipedia.org/wiki/Roswell_incident'),
  ('44444444-4444-4444-4444-444444444406', 'Encubrimiento militar', 'Independientemente de qué cayó, las contradicciones oficiales evidencian un encubrimiento deliberado.', 55, 'https://en.wikipedia.org/wiki/Roswell_incident'),
  -- Jonestown
  ('44444444-4444-4444-4444-444444444407', 'Suicidio inducido por coacción', 'Las grabaciones revelan que muchas muertes fueron forzadas, no voluntarias, bajo amenaza armada.', 80, 'https://jonestown.sdsu.edu/'),
  ('44444444-4444-4444-4444-444444444407', 'Control mental y aislamiento', 'Años de manipulación psicológica y "noches blancas" prepararon a la comunidad para el acto final.', 75, 'https://en.wikipedia.org/wiki/Jonestown'),
  ('44444444-4444-4444-4444-444444444407', 'Participación de fuerzas externas', 'Teorías marginales sugieren vínculos con experimentos gubernamentales, sin sustento documental.', 12, 'https://en.wikipedia.org/wiki/Jonestown'),
  -- Bélmez
  ('44444444-4444-4444-4444-444444444408', 'Teleplastia psíquica', 'Parapsicólogos proponen que la mente de María imprimía inconscientemente los rostros en el cemento.', 25, 'https://en.wikipedia.org/wiki/Bélmez_Faces'),
  ('44444444-4444-4444-4444-444444444408', 'Fraude con pigmentos', 'Análisis hallaron compuestos químicos, sugiriendo que las caras fueron pintadas deliberadamente.', 58, 'https://www.escepticos.es/belmez'),
  ('44444444-4444-4444-4444-444444444408', 'Influencia del cementerio', 'La presencia de restos humanos bajo la casa alimentó la idea de un fenómeno ligado a los muertos.', 22, 'https://en.wikipedia.org/wiki/Bélmez_Faces'),
  -- Enfield
  ('44444444-4444-4444-4444-444444444409', 'Actividad poltergeist genuina', 'La cantidad de testigos y registros sugiere un fenómeno paranormal real centrado en la adolescente.', 40, 'https://www.spr.ac.uk/'),
  ('44444444-4444-4444-4444-444444444409', 'Fraude infantil parcial', 'Las niñas admitieron fingir algunos episodios, lo que arroja dudas sobre todo el caso.', 55, 'https://en.wikipedia.org/wiki/Enfield_poltergeist'),
  ('44444444-4444-4444-4444-444444444409', 'Sugestión y histeria colectiva', 'El estrés familiar y la atención mediática pudieron amplificar percepciones e interpretaciones.', 48, 'https://en.wikipedia.org/wiki/Enfield_poltergeist'),
  -- Núremberg
  ('44444444-4444-4444-4444-444444444410', 'Fenómeno óptico (parhelio)', 'La ciencia atribuye el suceso a "soles falsos" y reflejos atmosféricos malinterpretados por los testigos.', 65, 'https://en.wikipedia.org/wiki/1561_celestial_phenomenon_over_Nuremberg'),
  ('44444444-4444-4444-4444-444444444410', 'Avistamiento OVNI temprano', 'Investigadores lo consideran una de las primeras observaciones masivas de objetos no identificados.', 30, 'https://en.wikipedia.org/wiki/1561_celestial_phenomenon_over_Nuremberg'),
  ('44444444-4444-4444-4444-444444444410', 'Histeria religiosa colectiva', 'El fervor apocalíptico del siglo XVI pudo moldear la percepción de un evento natural como señal divina.', 50, 'https://www.zeller-verlag.de/');

-- ─── SECCIÓN 5 — SOURCES ────────────────────────────────────────────────────
INSERT INTO sources (mystery_id, title, url, type, year) VALUES
  ('44444444-4444-4444-4444-444444444401', 'Dyatlov Pass incident — Wikipedia', 'https://en.wikipedia.org/wiki/Dyatlov_Pass_incident', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444401', 'Mechanisms of slab avalanche release — Communications Earth & Environment', 'https://www.nature.com/articles/s43247-020-00081-8', 'estudio', 2021),
  ('44444444-4444-4444-4444-444444444401', 'Dyatlov Pass: Keeping the dead’s secret — BBC', 'https://www.bbc.com/news/world-europe-51241675', 'reportaje', 2020),
  ('44444444-4444-4444-4444-444444444402', 'The Voynich Manuscript — Yale Beinecke Library', 'https://www.beinecke.library.yale.edu/collections/highlights/voynich-manuscript', 'archivo', 2016),
  ('44444444-4444-4444-4444-444444444402', 'Voynich manuscript — Wikipedia', 'https://en.wikipedia.org/wiki/Voynich_manuscript', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444402', 'The Mysterious Voynich Manuscript — Smithsonian Magazine', 'https://www.smithsonianmag.com/history/the-voynich-manuscript-180956529/', 'reportaje', 2015),
  ('44444444-4444-4444-4444-444444444403', 'Malaysia Airlines Flight 370 — Wikipedia', 'https://en.wikipedia.org/wiki/Malaysia_Airlines_Flight_370', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444403', 'The Operational Search for MH370 — ATSB', 'https://www.atsb.gov.au/mh370-pages/', 'informe', 2017),
  ('44444444-4444-4444-4444-444444444403', 'What Really Happened to Malaysia’s MH370 — The Atlantic', 'https://www.theatlantic.com/magazine/archive/2019/07/mh370-malaysia-airlines/590653/', 'reportaje', 2019),
  ('44444444-4444-4444-4444-444444444404', 'Project MKUltra — Senate Report', 'https://www.intelligence.senate.gov/sites/default/files/hearings/95mkultra.pdf', 'documento', 1977),
  ('44444444-4444-4444-4444-444444444404', 'Project MKUltra — Wikipedia', 'https://en.wikipedia.org/wiki/Project_MKUltra', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444404', 'CIA Reading Room: MKUltra Collection', 'https://www.cia.gov/readingroom/collection/mkultra', 'archivo', 2018),
  ('44444444-4444-4444-4444-444444444405', 'Zodiac Killer — FBI Famous Cases', 'https://www.fbi.gov/history/famous-cases/zodiac-killer', 'archivo', 2020),
  ('44444444-4444-4444-4444-444444444405', 'Zodiac Killer — Wikipedia', 'https://en.wikipedia.org/wiki/Zodiac_Killer', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444405', 'The Zodiac’s 340 cipher cracked — BBC', 'https://www.bbc.com/news/world-us-canada-55321161', 'reportaje', 2020),
  ('44444444-4444-4444-4444-444444444406', 'The Roswell Report — US Air Force', 'https://www.archives.gov/files/foia/the-roswell-report.pdf', 'informe', 1997),
  ('44444444-4444-4444-4444-444444444406', 'Roswell incident — Wikipedia', 'https://en.wikipedia.org/wiki/Roswell_incident', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444406', 'The Roswell Incident at 75 — Smithsonian Magazine', 'https://www.smithsonianmag.com/history/the-roswell-incident-180980276/', 'reportaje', 2022),
  ('44444444-4444-4444-4444-444444444407', 'Alternative Considerations of Jonestown — SDSU', 'https://jonestown.sdsu.edu/', 'archivo', 2020),
  ('44444444-4444-4444-4444-444444444407', 'Jonestown — Wikipedia', 'https://en.wikipedia.org/wiki/Jonestown', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444407', 'The Jonestown Massacre — History.com', 'https://www.history.com/topics/crime/jonestown', 'reportaje', 2018),
  ('44444444-4444-4444-4444-444444444408', 'Bélmez Faces — Wikipedia', 'https://en.wikipedia.org/wiki/Bélmez_Faces', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444408', 'Las caras de Bélmez — ARP-SAPC Escépticos', 'https://www.escepticos.es/node/belmez', 'análisis', 2014),
  ('44444444-4444-4444-4444-444444444408', 'The Faces of Bélmez — Skeptical Inquirer', 'https://skepticalinquirer.org/1993/03/the-belmez-faces/', 'análisis', 1993),
  ('44444444-4444-4444-4444-444444444409', 'Enfield poltergeist — Wikipedia', 'https://en.wikipedia.org/wiki/Enfield_poltergeist', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444409', 'The Enfield Poltergeist — Society for Psychical Research', 'https://www.spr.ac.uk/enfield-poltergeist', 'archivo', 2019),
  ('44444444-4444-4444-4444-444444444409', 'The Enfield Haunting Revisited — The Guardian', 'https://www.theguardian.com/lifeandstyle/2015/may/03/enfield-poltergeist-haunting', 'reportaje', 2015),
  ('44444444-4444-4444-4444-444444444410', '1561 celestial phenomenon over Nuremberg — Wikipedia', 'https://en.wikipedia.org/wiki/1561_celestial_phenomenon_over_Nuremberg', 'enciclopedia', 2023),
  ('44444444-4444-4444-4444-444444444410', 'Flying Saucers: A Modern Myth — C. G. Jung', 'https://www.jstor.org/stable/jung-flying-saucers', 'libro', 1958),
  ('44444444-4444-4444-4444-444444444410', 'The 1561 Nuremberg UFO sighting — Ancient Origins', 'https://www.ancient-origins.net/unexplained-phenomena/nuremberg-1561', 'reportaje', 2019);

-- ─── SECCIÓN 5 — MYSTERY_TAGS ───────────────────────────────────────────────
INSERT INTO mystery_tags (mystery_id, tag_id) VALUES
  -- Dyatlov: urss, radiacion, paranormal, archivos-clasificados
  ('44444444-4444-4444-4444-444444444401', '33333333-3333-3333-3333-333333333315'),
  ('44444444-4444-4444-4444-444444444401', '33333333-3333-3333-3333-333333333306'),
  ('44444444-4444-4444-4444-444444444401', '33333333-3333-3333-3333-333333333312'),
  ('44444444-4444-4444-4444-444444444401', '33333333-3333-3333-3333-333333333314'),
  -- Voynich: manuscrito, conspiracion, archivos-clasificados
  ('44444444-4444-4444-4444-444444444402', '33333333-3333-3333-3333-333333333307'),
  ('44444444-4444-4444-4444-444444444402', '33333333-3333-3333-3333-333333333311'),
  ('44444444-4444-4444-4444-444444444402', '33333333-3333-3333-3333-333333333314'),
  -- MH370: desaparicion, gobierno, conspiracion, testigos
  ('44444444-4444-4444-4444-444444444403', '33333333-3333-3333-3333-333333333305'),
  ('44444444-4444-4444-4444-444444444403', '33333333-3333-3333-3333-333333333310'),
  ('44444444-4444-4444-4444-444444444403', '33333333-3333-3333-3333-333333333311'),
  ('44444444-4444-4444-4444-444444444403', '33333333-3333-3333-3333-333333333313'),
  -- MK-Ultra: cia, experimento, gobierno, guerra-fria, archivos-clasificados
  ('44444444-4444-4444-4444-444444444404', '33333333-3333-3333-3333-333333333302'),
  ('44444444-4444-4444-4444-444444444404', '33333333-3333-3333-3333-333333333309'),
  ('44444444-4444-4444-4444-444444444404', '33333333-3333-3333-3333-333333333310'),
  ('44444444-4444-4444-4444-444444444404', '33333333-3333-3333-3333-333333333301'),
  ('44444444-4444-4444-4444-444444444404', '33333333-3333-3333-3333-333333333314'),
  -- Zodíaco: asesino-serial, conspiracion, testigos
  ('44444444-4444-4444-4444-444444444405', '33333333-3333-3333-3333-333333333308'),
  ('44444444-4444-4444-4444-444444444405', '33333333-3333-3333-3333-333333333311'),
  ('44444444-4444-4444-4444-444444444405', '33333333-3333-3333-3333-333333333313'),
  -- Roswell: ovni, gobierno, conspiracion, archivos-clasificados, testigos
  ('44444444-4444-4444-4444-444444444406', '33333333-3333-3333-3333-333333333303'),
  ('44444444-4444-4444-4444-444444444406', '33333333-3333-3333-3333-333333333310'),
  ('44444444-4444-4444-4444-444444444406', '33333333-3333-3333-3333-333333333311'),
  ('44444444-4444-4444-4444-444444444406', '33333333-3333-3333-3333-333333333314'),
  -- Jonestown: culto, gobierno, testigos
  ('44444444-4444-4444-4444-444444444407', '33333333-3333-3333-3333-333333333304'),
  ('44444444-4444-4444-4444-444444444407', '33333333-3333-3333-3333-333333333310'),
  ('44444444-4444-4444-4444-444444444407', '33333333-3333-3333-3333-333333333313'),
  -- Bélmez: paranormal, testigos
  ('44444444-4444-4444-4444-444444444408', '33333333-3333-3333-3333-333333333312'),
  ('44444444-4444-4444-4444-444444444408', '33333333-3333-3333-3333-333333333313'),
  -- Enfield: paranormal, testigos
  ('44444444-4444-4444-4444-444444444409', '33333333-3333-3333-3333-333333333312'),
  ('44444444-4444-4444-4444-444444444409', '33333333-3333-3333-3333-333333333313'),
  -- Núremberg: ovni, paranormal, testigos
  ('44444444-4444-4444-4444-444444444410', '33333333-3333-3333-3333-333333333303'),
  ('44444444-4444-4444-4444-444444444410', '33333333-3333-3333-3333-333333333312'),
  ('44444444-4444-4444-4444-444444444410', '33333333-3333-3333-3333-333333333313');

-- ─── SECCIÓN 6 — MYSTERY_RELATIONS ──────────────────────────────────────────
INSERT INTO mystery_relations (mystery_id, related_mystery_id, relation_type) VALUES
  ('44444444-4444-4444-4444-444444444401', '44444444-4444-4444-4444-444444444406', 'fenomeno-inexplicable'),
  ('44444444-4444-4444-4444-444444444404', '44444444-4444-4444-4444-444444444406', 'gobierno-clasificado'),
  ('44444444-4444-4444-4444-444444444405', '44444444-4444-4444-4444-444444444407', 'violencia-masiva');

-- ─── SECCIÓN 7 — FEATURED_CONTENT ───────────────────────────────────────────
INSERT INTO featured_content (mystery_id, type, position, active) VALUES
  ('44444444-4444-4444-4444-444444444401', 'day', 0, true),
  ('44444444-4444-4444-4444-444444444403', 'hero', 0, true),
  ('44444444-4444-4444-4444-444444444402', 'carousel', 1, true),
  ('44444444-4444-4444-4444-444444444404', 'carousel', 2, true),
  ('44444444-4444-4444-4444-444444444405', 'carousel', 3, true);
