# Coming Home - Zombie Wave Survival

Godot 4.3+ ile yapılmış, hikaye anlatan top-down "twin-stick shooter + zombi hayatta kalma" oyunu. Tamamen İngilizce.

## Hikaye

**Ryan Cole**, eski asker / güvenlik görevlisi. Salgın patlak verdiğinde nöbetteydi. Şehir kilitlenince eşi **Sarah** ve kızı **Emma**'ya ulaşamadı. Onları bulmak için harabeye dönen şehri baştan sona geçiyor: mahalle → hastane → askeri kontrol noktası → metro → tünel (boss ile final) → (devamı geliyor) stadyum.

## Nasıl çalıştırılır

1. [Godot 4.3+](https://godotengine.org/download) indir ve aç.
2. "Import" diyerek bu klasördeki `project.godot` dosyasını seç.
3. Üstteki Play (▶) tuşuna bas.

## Kontroller

- **WASD** — move
- **Mouse** — aim (crosshair cursor, ayarlanabilir)
- **Left click** — shoot
- **R** — reload
- **E** — talk to nearby character
- **F** — toggle flashlight (sadece Tunnel bölümünde)
- **1 / 2 / 3 / 4** — switch weapon (Pistol / Shotgun / Rifle / Rocket Launcher — roket atarı boss'u yenince açılıyor)
- **Click / SPACE** — advance dialogue

## Bölümler

1. **Neighborhood** — açılış, Sarah'nın notu, günlükler
2. **Hospital** — Nurse Diane (konuşulabilir NPC), yatak/araba engelleri
3. **Military Checkpoint** — Sgt. Briggs + 2 asker müttefik (otomatik olarak zombilere ateş ediyorlar), devrilmiş askeri araç
4. **Subway Terminal + Tunnel** — iki parçalı bölüm:
   - Terminal: cesetler, kan izleri, kaçan insanlardan kalan notlar
   - Tunnel: **karanlık**, F ile açılan fener ışığı (gerçek Godot 2D lighting), sonunda **boss savaşı**
5-6. Yakında

## Boss: Mutated Horror

Tünelin sonunda bekleyen dev, çok-gözlü mutant. Uzaktan biyolojik/kimyasal atık parçaları fırlatıyor (kaçınılabilir), yakına gelirse ağır melee hasarı veriyor. Ekranın üstünde can barı görünüyor. Yenilince **Roket Atarı** bırakıyor — bir sonraki bölümde kullanılabilir.

## Ayarlar Menüsü

Ana menüden "SETTINGS" ile erişilir:
- **Volume** — ses seviyesi
- **Crosshair** — Classic / Dot / Cross / Off
- **Character Color** — Green / Blue / Red / Grey
- **Show FPS** — sağ üstte FPS sayacı

Tüm ayarlar ve high score kalıcı olarak diskte saklanır (`user://save_data.json`).

## Mermi/Şarjör Sistemi

- **Pistol** — sınırsız mermi
- **Shotgun** — 6 mermi/şarjör × 4 şarjör (24 toplam)
- **Rifle** — 30 mermi/şarjör × 4 şarjör (120 toplam)
- **Rocket Launcher** — 1 mermi/şarjör × 4 şarjör (boss'tan sonra açılır)

**R** ile şarjör değiştir. Zombiler ölünce şansla **mermi paketi** (sarı) veya **can paketi** (kırmızı) düşürüyor.

## Proje yapısı

```
zombie_survival/
├── project.godot
├── audio/                # Prosedürel üretilmiş .wav ses efektleri
├── sprites/               # Prosedürel üretilmiş .png karakter/UI/portre/dekor görselleri
├── scenes/
│   ├── MainMenu.tscn, Settings.tscn
│   ├── Main.tscn, Hospital.tscn, Checkpoint.tscn, Subway.tscn, Tunnel.tscn
│   ├── DialogueBox.tscn, Npc.tscn, Ally.tscn, Obstacle.tscn
│   ├── Player.tscn, Zombie.tscn, Boss.tscn, Bullet.tscn, BossProjectile.tscn
│   ├── PowerUp.tscn, Loot.tscn, DiaryLog.tscn
└── scripts/
    ├── SFX.gd, SaveData.gd          # Autoload'lar
    ├── Story.gd                     # Tum diyalog verileri
    ├── DialogueBox.gd, Npc.gd, Ally.gd, Obstacle.gd
    ├── MainMenu.gd, Settings.gd
    ├── Main.gd, Hospital.gd, Checkpoint.gd, Subway.gd, Tunnel.gd
    ├── Player.gd, Zombie.gd, Boss.gd, Bullet.gd, BossProjectile.gd
    └── PowerUp.gd, Loot.gd, DiaryLog.gd
```

## Sıradaki yapılacaklar (todo)

1. Bölüm 5-6: Refugee Camp Outskirts, Stadium (final — Sarah ve Emma'ya kavuşma)
2. Görsel/animasyon iyileştirmeleri (bu iskelet tamamlanınca planlanan)
3. Kill streak/combo skor sistemi
4. Minimap/radar
