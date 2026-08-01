# Zombie Wave Survival

Godot 4.3+ ile yapılmış top-down "twin-stick shooter + zombi hayatta kalma" mini oyunu.

## Nasıl çalıştırılır

1. [Godot 4.3+](https://godotengine.org/download) indir ve aç.
2. "Import" diyerek bu klasördeki `project.godot` dosyasını seç.
3. Üstteki Play (▶) tuşuna bas.

## Kontroller

- **WASD** — hareket
- **Mouse** — nişan alma
- **Sol tık** — ateş et

## Özellikler

- **Ana menü** — Başla / Çıkış, en yüksek skoru gösterir
- **Dalga sistemi** — her dalgada zombi sayısı artar (`4 + dalga * 2`)
- **3 zombi tipi**:
  - Normal (kırmızı) — dengeli
  - Hızlı (turuncu, küçük) — az can, hızlı, düşük hasar
  - Tanky (mor, büyük) — çok can, yavaş, yüksek hasar (3. dalgadan sonra çıkar)
- **Power-up'lar** (ekranda rastgele belirir, 10 saniyede kaybolur):
  - Mavi — hız artışı (8 saniye)
  - Turuncu — çoklu atış (8 saniye, 3'lü spread)
  - Pembe — 30 can yenileme
- **Ses efektleri** — ateş, isabet, zombi ölümü, hasar alma, power-up, dalga başlangıcı, oyun sonu (prosedürel/sentetik üretildi)
- **Basit animasyonlar** — zombi yürüyüş salınımı, hasar flaşı, ölüm animasyonu (küçülüp kaybolma), power-up süzülme efekti
- **Local high score** — `user://highscore.save` dosyasında saklanır, kalıcıdır
- **Game Over ekranı** — Yeniden Başla ve Ana Menü butonları

## Proje yapısı

```
zombie_survival/
├── project.godot
├── audio/              # Prosedürel üretilmiş .wav ses efektleri
├── scenes/
│   ├── MainMenu.tscn   # Ana menü
│   ├── Main.tscn       # Oyun sahnesi (oyuncu, HUD, spawner)
│   ├── Player.tscn
│   ├── Zombie.tscn
│   ├── Bullet.tscn
│   └── PowerUp.tscn
└── scripts/
    ├── SFX.gd          # Autoload - ses çalma havuzu
    ├── SaveData.gd     # Autoload - high score kayıt/yükleme
    ├── MainMenu.gd
    ├── Main.gd         # Dalga yönetimi, spawn, skor
    ├── Player.gd       # Hareket, ateş, power-up efektleri, can
    ├── Zombie.gd        # 3 tip AI, animasyon, ölüm
    ├── Bullet.gd
    └── PowerUp.gd
```

## Geliştirme fikirleri (istersen ekleriz)

- Farklı silahlar (shotgun, makineli)
- Boss zombi (her 5 dalgada bir)
- Ana menüde ses/müzik açma-kapama ayarı
- Gerçek pixel-art sprite'lar (şu an düz renkli poligonlar kullanılıyor)
- Online skor tablosu
