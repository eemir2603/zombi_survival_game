# Zombie Wave Survival

Godot 4.3+ ile yapılmış top-down "twin-stick shooter + zombi hayatta kalma" karışımı mini oyun.

## Nasıl çalıştırılır

1. [Godot 4.3+](https://godotengine.org/download) indir ve aç.
2. "Import" diyerek bu klasördeki `project.godot` dosyasını seç.
3. Üstteki Play (▶) tuşuna bas.

## Kontroller

- **WASD** — hareket
- **Mouse** — nişan alma (karakter mouse'a bakar)
- **Sol tık** — ateş et

## Oynanış

- Zombiler ekranın kenarlarından dalga dalga geliyor.
- Her dalgada zombi sayısı artıyor (`4 + dalga * 2`).
- Zombi öldürünce +10 skor.
- Zombi sana değince hasar veriyor, canın biterse "Game Over" ekranı geliyor.
- Game Over ekranındaki "Yeniden Başla" butonu sahneyi resetliyor.

## Proje yapısı

```
zombie_survival/
├── project.godot
├── scenes/
│   ├── Main.tscn      # Ana sahne (oyuncu, HUD, spawner)
│   ├── Player.tscn
│   ├── Zombie.tscn
│   └── Bullet.tscn
└── scripts/
    ├── Main.gd        # Dalga yönetimi, skor, oyun sonu
    ├── Player.gd      # Hareket, nişan, ateş, can
    ├── Zombie.gd      # Takip AI, saldırı
    ├── Bullet.gd      # Mermi hareketi ve hasar
    └── HUD.gd         # Arayüz güncellemeleri
```

## Geliştirme fikirleri (istersen ekleriz)

- Farklı zombi tipleri (hızlı/tanky)
- Power-up'lar (hız artışı, çoklu atış, can yenileme)
- Basit sprite/animasyon ekleme (şu an düz renkli poligonlar kullanılıyor)
- Ses efektleri (ateş, zombi ölümü, hasar alma)
- Ana menü ve skor tablosu (local high score)
