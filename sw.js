// Alaa Deals — يخلّي السيستم يتثبت كتطبيق ويفتح بسرعة. البيانات نفسها دايماً من Supabase.
const CACHE = 'alaa-deals-v2';
const SHELL = ['./', 'index.html', 'config.js', 'logo-mark.webp', 'logo-full.webp', 'icon-192.png', 'manifest.webmanifest'];
self.addEventListener('install', e => { e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting())); });
self.addEventListener('activate', e => { e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim())); });
self.addEventListener('fetch', e => {
  const u = new URL(e.request.url);
  if (e.request.method !== 'GET' || u.hostname.endsWith('supabase.co')) return;
  const isLib = /cdnjs\.cloudflare\.com|cdn\.jsdelivr\.net|fonts\.(googleapis|gstatic)\.com/.test(u.hostname);
  if (u.origin !== location.origin && !isLib) return;
  e.respondWith(
    fetch(e.request).then(r => { if (r.ok || r.type === 'opaque') { const cp = r.clone(); caches.open(CACHE).then(c => c.put(e.request, cp)); } return r; })
      .catch(() => caches.match(e.request).then(r => r || caches.match('index.html')))
  );
});
