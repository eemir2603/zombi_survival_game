# Coming Home — Zombie Wave Survival

Godot 4.3+ ile yapılmış, hikaye anlatan top-down twin-stick shooter / zombi hayatta kalma oyunu.

## Hikaye

**Ryan Cole**, eski asker / güvenlik görevlisi. Salgın patlak verdiğinde nöbetteydi. Şehir kilitlenince eşi **Sarah** ve kızı **Emma**'ya ulaşamadı. Onları bulmak için harabeye dönen şehri baştan sona geçiyor.

## Nasıl çalıştırılır

1. [Godot 4.3+](https://godotengine.org/download) indir.
2. "Import" → bu klasördeki `project.godot` dosyasını seç.
3. Play (▶).

## Kontroller

| Tuş | İşlev |
|---|---|
| WASD | Hareket |
| Mouse | Nişan (crosshair, ayarlardan değiştirilebilir) |
| Sol tık | Ateş |
| R | Şarjör değiştir |
| E | Yakındaki karakterle konuş |
| F | El feneri (sadece Tunnel) |
| 1 / 2 / 3 / 4 | Silah değiştir |
| Tık / SPACE | Diyalogda ilerle |

## Bölümler

1. **Neighborhood** — açılış, Sarah'nın notu, 3 günlük
2. **Hospital** — Nurse Diane (NPC), yatak/araba engelleri
3. **Military Checkpoint** — Sgt. Briggs + 2 asker müttefik, devrilmiş HMMWV
4. **Subway Terminal → Tunnel** — cesetler/kan/notlar, sonra karanlık tünel (F ile fener) ve **boss savaşı** (Mutated Horror → Roket Atarı düşürür)
5. **Refugee Camp Outskirts** — çamurlu kamp, **Maya Reyes** (NPC), çadırlar ve variller siper olarak, 2 sivil gönüllü müttefik, 6 dalga savunma.
6. **Stadium** *(YENİ — FİNAL)* — üç aşamalı final. Detaylar aşağıda.

## Bölüm 6: Stadium — yeni oynanış

Diğer bölümlerden yapısal olarak farklı çalışır:

**Faz 1 — Yaklaşma.** 3 dalga normal temizlik, konkora ulaşma.

**Faz 2 — Kavuşma.** Sarah ve Emma bulunur. Sarah bir saat önce kapıda ısırılmıştır; Emma'yla gelen arasında durduğu için. Otobüste tek koltuk vardır ve Sarah onu almayı reddeder.

**Faz 3 — Tahliye Savunması.** *(tamamen yeni mekanik)* Dalga saymak yok — **120 saniye** var. Zombiler kesintisiz gelir ve **%45'i oyuncuyu görmezden gelip doğrudan otobüse saldırır**. Otobüsün kendi can barı vardır (700 HP); sıfırlanırsa bölüm kaybedilir ("THE BUS IS GONE"). Bu fazda mermi/can düşme oranı yükseltilmiştir çünkü kaynak yönetimi kritiktir. Ekranda geri sayım + otobüs bütünlüğü göstergeleri.

**Faz 4 — Final.** Otobüs dolar ve yola çıkar. **Sarah geride kalır, Emma kurtulur.** Ryan kızını alıp gider ve arkasına bakmaz, çünkü bakmayacağına söz vermiştir.

## Silahlar

| Silah | Şarjör | Not |
|---|---|---|
| Pistol | Sınırsız | Dengeli |
| Shotgun | 6 × 4 | 5 saçma, yakın mesafe |
| Rifle | 30 × 4 | Hızlı ateş, yüksek DPS |
| Rocket Launcher | 1 × 4 | Boss'tan sonra açılır (tuş 4) |

Zombiler ölünce şansla **mermi** (sarı) veya **can** (kırmızı) paketi düşürür.

## Ayarlar (ana menü → SETTINGS)

Ses seviyesi · Crosshair stili (Classic/Dot/Cross/Off) · Karakter rengi (Green/Blue/Red/Grey) · FPS göstergesi — hepsi `user://save_data.json` içinde kalıcı.

## Teknik notlar

- Tüm görseller ve sesler **prosedürel olarak üretildi** (Python: PIL + wave modülü). Hiç dış asset yok.
- El feneri `Tunnel.gd` içinde kod ile oluşturulur (`PointLight2D.new()`), sahne dosyasına gömülü değil.
- `DialogueBox.gd` sahne geçişlerinde `get_viewport()` null kontrolü ve `is_inside_tree()` koruması içerir.

## Yapı

```
zombie_survival/
├── project.godot
├── audio/     # 9 prosedürel .wav
├── sprites/   # 13 karakter + 28 UI/dekor .png
├── scenes/    # 22 .tscn
└── scripts/   # 25 .gd
```

## Sıradaki

1. Görsel/animasyon cilası (yürüme animasyonları, parçacık efektleri, ekran sarsıntısı)
2. Kill streak / combo skor
3. Minimap / radar
4. Bölümler arası silah/geliştirme seçimi ekranı
