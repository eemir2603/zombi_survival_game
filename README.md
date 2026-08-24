# Zombie Wave Survival — "Coming Home" (Chapter 1)

Godot 4.3+ ile yapılmış, hikaye anlatan top-down "twin-stick shooter + zombi hayatta kalma" oyunu.

## Hikaye

**Ryan Cole**, eski asker / güvenlik görevlisi. Salgın patlak verdiğinde nöbetteydi. Şehir kilitlenince eşi **Sarah** ve kızı **Emma**'ya ulaşamadı. Onları bulmak için harabeye dönen şehri baştan sona geçiyor.

Bölüm 1: Ryan, evine ulaşıyor — kimse yok, ama Sarah'nın bıraktığı bir not var. Hastaneye gitmişler. Sokakları zombilerden temizleyip yola koyulması gerekiyor.

## Nasıl çalıştırılır

1. [Godot 4.3+](https://godotengine.org/download) indir ve aç.
2. "Import" diyerek bu klasördeki `project.godot` dosyasını seç.
3. Üstteki Play (▶) tuşuna bas.

## Kontroller

- **WASD** — hareket
- **Mouse** — nişan alma (crosshair imleç)
- **Sol tık** — ateş et
- **E** — yakınındaki karakterle konuş
- **1 / 2 / 3** — silah değiştir (Tabanca / Pompalı / Tüfek)
- **Tıkla / SPACE** — diyalogda ilerle

## Özellikler

- **Hikaye/ara sahne sistemi** — portre + karakter adı + daktilo efektli yazı, tıklayarak ilerlenen diyalog kutusu (`DialogueBox`)
- **Bölüm 1 anlatısı** — açılış sahnesi, Sarah'nın notu, 5 dalga sonunda bölüm kapanışı
- **Toplanabilir günlükler** — haritada saklı 3 adet "Ryan's Journal" notu, ek arka hikaye anlatıyor
- **Bölüm tamamlama ekranı** — "Sonsuz Moda Devam Et" (mevcut sistemle sınırsız oynanış) veya "Ana Menü"
- **Ana menü** — Başla / Çıkış, ses seviyesi slider'ı, en yüksek skor gösterimi
- **Dalga sistemi** — her dalgada zombi sayısı artar
- **3 zombi tipi** — Normal, Hızlı, Tanky (kendi sprite'ları ve istatistikleriyle)
- **3 silah** (1/2/3 ile değiştirilir) — Tabanca, Pompalı, Tüfek
- **Power-up'lar** — hız artışı, çoklu atış, can yenileme
- **Ses efektleri** — hepsi prosedürel/sentetik üretildi (ateş, isabet, zombi ölümü, zombi inleme, hasar, power-up, dalga başlangıcı, oyun sonu, menü tıklaması)
- **Karakter portreleri ve sprite'lar** — kod ile üretilmiş görseller
- **Local high score** — kalıcı olarak saklanır

## Bilinen düzeltmeler

- **[Düzeltildi]** Zombiler fiziksel çarpışma nedeniyle oyuncuya saldırı-tetikleme mesafesinden daha yakına gelemiyordu, bu yüzden hasar veremiyorlardı. Saldırı mesafeleri artık fiziksel çarpışma mesafesini kapsayacak şekilde ayarlandı.

## Proje yapısı

```
zombie_survival/
├── project.godot
├── audio/               # Prosedürel üretilmiş .wav ses efektleri
├── sprites/              # Prosedürel üretilmiş .png karakter/UI/portre görselleri
├── scenes/
│   ├── MainMenu.tscn
│   ├── Main.tscn
│   ├── DialogueBox.tscn  # Yeniden kullanılabilir diyalog/ara sahne sistemi
│   ├── DiaryLog.tscn     # Toplanabilir hikaye günlüğü
│   ├── Player.tscn
│   ├── Zombie.tscn
│   ├── Bullet.tscn
│   └── PowerUp.tscn
└── scripts/
    ├── SFX.gd            # Autoload - ses çalma havuzu
    ├── SaveData.gd       # Autoload - high score kayıt/yükleme
    ├── Story.gd          # Bölüm 1 diyalog verileri
    ├── DialogueBox.gd
    ├── DiaryLog.gd
    ├── MainMenu.gd
    ├── Main.gd
    ├── Player.gd
    ├── Zombie.gd
    ├── Bullet.gd
    └── PowerUp.gd
```

## Sıradaki yapılacaklar (todo)

1. ~~Bölüm 2: Hastane haritası + Nurse Diane karakteri~~ ✅ eklendi
2. ~~Bölüm 3: Askeri Kontrol Noktası + Sergeant Briggs + savaşan asker müttefikler~~ ✅ eklendi
3. ~~Crosshair~~ ✅ eklendi
4. Bölüm 4-6: Metro/Tüneller, Mülteci Kampı Çevresi, Stadyum (final — Sarah ve Emma'ya kavuşma)
5. Ayarlar menüsü güncellemesi (planlandı)
6. Loot sistemi (zombi ölünce eşya/silah/can düşürmesi)
7. Fikir havuzu: minimap/radar, kill streak/combo skor, şarjör/reload mekaniği
