# Alaa Deals — CRM عقاري

سيستم لتسجيل العملاء والوحدات والصفقات. الواجهة ملف HTML ثابت، وقاعدة البيانات والدخول على Supabase.

## الملفات
| الملف | الوظيفة |
|---|---|
| `index.html` | السيستم كله |
| `config.js` | رابط ومفتاح مشروع Supabase |
| `supabase-schema.sql` | الجداول والحماية (لمشروع جديد) |
| `supabase-update-brokers.sql` | تحديث خانة المكاتب (لو شغّلت الملف الأول قبل كده) |
| `manifest.webmanifest` / `sw.js` / `icon-*.png` | تثبيت السيستم كتطبيق على الموبايل والكمبيوتر |
| `logo-full.webp` / `logo-mark.webp` | اللوجو |

## التشغيل

### 1) Supabase
1. اعمل مشروع جديد على supabase.com.
2. **SQL Editor → New query**: الصق محتوى `supabase-schema.sql` واضغط Run.
3. **Authentication → Sign In / Providers → Email**: اقفل **Allow new users to sign up** (عشان محدش يعمل حساب غيرك)، واقفل **Confirm email**.
4. **Authentication → Users → Add user → Create new user**:
   - Email: `اسم-المستخدم@alaadeals.app` (مثلاً `alaa@alaadeals.app`)
   - Password: كلمة السر
   - علّم **Auto Confirm User**
5. **Project Settings → API**: انسخ **Project URL** و **anon public key** وحطهم في `config.js`.

### 2) GitHub
1. اعمل repository جديد (مثلاً `alaa-deals`) وارفع كل الملفات.
2. للنشر: **Vercel → Add New Project → Import** الـ repo (من غير أي إعدادات بناء)، أو **GitHub Pages** من Settings → Pages → Branch: main.
3. اربط الدومين لو عندك.

### الدخول
في صفحة اللوجين اكتب اسم المستخدم بس (`alaa`) وكلمة السر — السيستم بيكمّل الإيميل لوحده.
لإضافة مستخدم تاني: Add user بإيميل `اسمه@alaadeals.app`.

### التحميل والنسخ الاحتياطي
- كل خانة فيها زر **Excel** بيحمّل اللي ظاهر قدامك (بعد البحث والفلتر).
- زر **تحميل البيانات** في القائمة: ملف Excel كامل بكل الخانات، أو نسخة احتياطية `.json` تقدر ترجّع منها في أي وقت.

### التثبيت كتطبيق
بعد النشر على رابط https: افتح السيستم من الموبايل وهتلاقي في **تحميل البيانات** زر التثبيت (أندرويد/كروم)، أو من Safari: مشاركة ← إضافة إلى الشاشة الرئيسية.
