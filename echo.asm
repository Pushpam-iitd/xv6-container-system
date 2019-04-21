
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  for(i = 1; i < argc; i++)
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 3f                	jle    5c <main+0x5c>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	eb 18                	jmp    3d <main+0x3d>
  25:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  28:	68 68 0b 00 00       	push   $0xb68
  2d:	50                   	push   %eax
  2e:	68 6a 0b 00 00       	push   $0xb6a
  33:	6a 01                	push   $0x1
  35:	e8 d6 07 00 00       	call   810 <printf>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	83 c3 04             	add    $0x4,%ebx
  40:	8b 43 fc             	mov    -0x4(%ebx),%eax
  43:	39 f3                	cmp    %esi,%ebx
  45:	75 e1                	jne    28 <main+0x28>
  47:	68 79 0b 00 00       	push   $0xb79
  4c:	50                   	push   %eax
  4d:	68 6a 0b 00 00       	push   $0xb6a
  52:	6a 01                	push   $0x1
  54:	e8 b7 07 00 00       	call   810 <printf>
  59:	83 c4 10             	add    $0x10,%esp
  exit();
  5c:	e8 15 06 00 00       	call   676 <exit>
  61:	66 90                	xchg   %ax,%ax
  63:	66 90                	xchg   %ax,%ax
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	84 c0                	test   %al,%al
  b2:	75 1c                	jne    d0 <strcmp+0x30>
  b4:	eb 2a                	jmp    e0 <strcmp+0x40>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  c6:	83 c1 01             	add    $0x1,%ecx
  c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x40>
  d0:	38 d8                	cmp    %bl,%al
  d2:	74 ec                	je     c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  d4:	29 d8                	sub    %ebx,%eax
}
  d6:	5b                   	pop    %ebx
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e2:	29 d8                	sub    %ebx,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 110:	31 c0                	xor    %eax,%eax
}
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	74 1d                	je     16e <strchr+0x2e>
    if(*s == c)
 151:	38 d3                	cmp    %dl,%bl
 153:	89 d9                	mov    %ebx,%ecx
 155:	75 0d                	jne    164 <strchr+0x24>
 157:	eb 17                	jmp    170 <strchr+0x30>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
  for(; *s; s++)
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
 16e:	31 c0                	xor    %eax,%eax
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	31 f6                	xor    %esi,%esi
 188:	89 f3                	mov    %esi,%ebx
{
 18a:	83 ec 1c             	sub    $0x1c,%esp
 18d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 190:	eb 2f                	jmp    1c1 <gets+0x41>
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 198:	8d 45 e7             	lea    -0x19(%ebp),%eax
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	6a 01                	push   $0x1
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 e6 04 00 00       	call   68e <read>
    if(cc < 1)
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	85 c0                	test   %eax,%eax
 1ad:	7e 1c                	jle    1cb <gets+0x4b>
      break;
    buf[i++] = c;
 1af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b3:	83 c7 01             	add    $0x1,%edi
 1b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1b9:	3c 0a                	cmp    $0xa,%al
 1bb:	74 23                	je     1e0 <gets+0x60>
 1bd:	3c 0d                	cmp    $0xd,%al
 1bf:	74 1f                	je     1e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1c1:	83 c3 01             	add    $0x1,%ebx
 1c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c7:	89 fe                	mov    %edi,%esi
 1c9:	7c cd                	jl     198 <gets+0x18>
 1cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1d6:	5b                   	pop    %ebx
 1d7:	5e                   	pop    %esi
 1d8:	5f                   	pop    %edi
 1d9:	5d                   	pop    %ebp
 1da:	c3                   	ret    
 1db:	90                   	nop
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	8b 75 08             	mov    0x8(%ebp),%esi
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	01 de                	add    %ebx,%esi
 1e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 a4 04 00 00       	call   6b6 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	pushl  0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 a7 04 00 00       	call   6ce <fstat>
  close(fd);
 227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22a:	89 c6                	mov    %eax,%esi
  close(fd);
 22c:	e8 6d 04 00 00       	call   69e <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 11             	movsbl (%ecx),%edx
 25a:	8d 42 d0             	lea    -0x30(%edx),%eax
 25d:	3c 09                	cmp    $0x9,%al
  n = 0;
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 264:	77 1f                	ja     285 <atoi+0x35>
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 270:	8d 04 80             	lea    (%eax,%eax,4),%eax
 273:	83 c1 01             	add    $0x1,%ecx
 276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 27a:	0f be 11             	movsbl (%ecx),%edx
 27d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	5b                   	pop    %ebx
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 5d 10             	mov    0x10(%ebp),%ebx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2b2:	39 d3                	cmp    %edx,%ebx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
  return vdst;
}
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	66 90                	xchg   %ax,%ax
 2bc:	66 90                	xchg   %ax,%ax
 2be:	66 90                	xchg   %ax,%ax

000002c0 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	56                   	push   %esi
 2c4:	53                   	push   %ebx
 2c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 2c8:	31 db                	xor    %ebx,%ebx
{
 2ca:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 2cd:	80 39 00             	cmpb   $0x0,(%ecx)
 2d0:	0f b6 02             	movzbl (%edx),%eax
 2d3:	74 33                	je     308 <mystrcmp+0x48>
 2d5:	8d 76 00             	lea    0x0(%esi),%esi
 2d8:	83 c1 01             	add    $0x1,%ecx
 2db:	83 c3 01             	add    $0x1,%ebx
 2de:	80 39 00             	cmpb   $0x0,(%ecx)
 2e1:	75 f5                	jne    2d8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 2e3:	84 c0                	test   %al,%al
 2e5:	74 51                	je     338 <mystrcmp+0x78>
    int a =0,b=0;
 2e7:	31 f6                	xor    %esi,%esi
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	83 c6 01             	add    $0x1,%esi
 2f6:	80 3a 00             	cmpb   $0x0,(%edx)
 2f9:	75 f5                	jne    2f0 <mystrcmp+0x30>

    if(a!=b)return 0;
 2fb:	31 c0                	xor    %eax,%eax
 2fd:	39 de                	cmp    %ebx,%esi
 2ff:	74 0f                	je     310 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 301:	5b                   	pop    %ebx
 302:	5e                   	pop    %esi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 308:	84 c0                	test   %al,%al
 30a:	75 db                	jne    2e7 <mystrcmp+0x27>
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	01 d3                	add    %edx,%ebx
 312:	eb 13                	jmp    327 <mystrcmp+0x67>
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 318:	83 c2 01             	add    $0x1,%edx
 31b:	83 c1 01             	add    $0x1,%ecx
 31e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 322:	38 41 ff             	cmp    %al,-0x1(%ecx)
 325:	75 11                	jne    338 <mystrcmp+0x78>
    while(a--){
 327:	39 d3                	cmp    %edx,%ebx
 329:	75 ed                	jne    318 <mystrcmp+0x58>
}
 32b:	5b                   	pop    %ebx
    return 1;
 32c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 331:	5e                   	pop    %esi
 332:	5d                   	pop    %ebp
 333:	c3                   	ret    
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 338:	5b                   	pop    %ebx
    if(a!=b)return 0;
 339:	31 c0                	xor    %eax,%eax
}
 33b:	5e                   	pop    %esi
 33c:	5d                   	pop    %ebp
 33d:	c3                   	ret    
 33e:	66 90                	xchg   %ax,%ax

00000340 <fmtname>:

char*
fmtname(char *path)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
 345:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 348:	83 ec 0c             	sub    $0xc,%esp
 34b:	53                   	push   %ebx
 34c:	e8 9f fd ff ff       	call   f0 <strlen>
 351:	83 c4 10             	add    $0x10,%esp
 354:	01 d8                	add    %ebx,%eax
 356:	73 0f                	jae    367 <fmtname+0x27>
 358:	eb 12                	jmp    36c <fmtname+0x2c>
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 360:	83 e8 01             	sub    $0x1,%eax
 363:	39 c3                	cmp    %eax,%ebx
 365:	77 05                	ja     36c <fmtname+0x2c>
 367:	80 38 2f             	cmpb   $0x2f,(%eax)
 36a:	75 f4                	jne    360 <fmtname+0x20>
    ;
  p++;
 36c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 36f:	83 ec 0c             	sub    $0xc,%esp
 372:	53                   	push   %ebx
 373:	e8 78 fd ff ff       	call   f0 <strlen>
 378:	83 c4 10             	add    $0x10,%esp
 37b:	83 f8 0d             	cmp    $0xd,%eax
 37e:	77 4a                	ja     3ca <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 380:	83 ec 0c             	sub    $0xc,%esp
 383:	53                   	push   %ebx
 384:	e8 67 fd ff ff       	call   f0 <strlen>
 389:	83 c4 0c             	add    $0xc,%esp
 38c:	50                   	push   %eax
 38d:	53                   	push   %ebx
 38e:	68 40 0f 00 00       	push   $0xf40
 393:	e8 f8 fe ff ff       	call   290 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 398:	89 1c 24             	mov    %ebx,(%esp)
 39b:	e8 50 fd ff ff       	call   f0 <strlen>
 3a0:	89 1c 24             	mov    %ebx,(%esp)
 3a3:	89 c6                	mov    %eax,%esi
  return buf;
 3a5:	bb 40 0f 00 00       	mov    $0xf40,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3aa:	e8 41 fd ff ff       	call   f0 <strlen>
 3af:	ba 0e 00 00 00       	mov    $0xe,%edx
 3b4:	83 c4 0c             	add    $0xc,%esp
 3b7:	05 40 0f 00 00       	add    $0xf40,%eax
 3bc:	29 f2                	sub    %esi,%edx
 3be:	52                   	push   %edx
 3bf:	6a 20                	push   $0x20
 3c1:	50                   	push   %eax
 3c2:	e8 59 fd ff ff       	call   120 <memset>
  return buf;
 3c7:	83 c4 10             	add    $0x10,%esp
}
 3ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3cd:	89 d8                	mov    %ebx,%eax
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5d                   	pop    %ebp
 3d2:	c3                   	ret    
 3d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <ls>:

void
ls(char *path)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 3ec:	e8 6d 03 00 00       	call   75e <getcid>

  printf(2, "Cid is: %d\n", cid);
 3f1:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 3f4:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 3f6:	50                   	push   %eax
 3f7:	68 6f 0b 00 00       	push   $0xb6f
 3fc:	6a 02                	push   $0x2
 3fe:	e8 0d 04 00 00       	call   810 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 403:	59                   	pop    %ecx
 404:	5b                   	pop    %ebx
 405:	6a 00                	push   $0x0
 407:	ff 75 08             	pushl  0x8(%ebp)
 40a:	e8 a7 02 00 00       	call   6b6 <open>
 40f:	83 c4 10             	add    $0x10,%esp
 412:	85 c0                	test   %eax,%eax
 414:	78 5a                	js     470 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 416:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 41c:	83 ec 08             	sub    $0x8,%esp
 41f:	89 c3                	mov    %eax,%ebx
 421:	56                   	push   %esi
 422:	50                   	push   %eax
 423:	e8 a6 02 00 00       	call   6ce <fstat>
 428:	83 c4 10             	add    $0x10,%esp
 42b:	85 c0                	test   %eax,%eax
 42d:	0f 88 cd 00 00 00    	js     500 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 433:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 43a:	66 83 f8 01          	cmp    $0x1,%ax
 43e:	74 50                	je     490 <ls+0xb0>
 440:	66 83 f8 02          	cmp    $0x2,%ax
 444:	75 12                	jne    458 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 446:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 44c:	8d 42 01             	lea    0x1(%edx),%eax
 44f:	83 f8 01             	cmp    $0x1,%eax
 452:	76 6c                	jbe    4c0 <ls+0xe0>
 454:	39 fa                	cmp    %edi,%edx
 456:	74 68                	je     4c0 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 458:	83 ec 0c             	sub    $0xc,%esp
 45b:	53                   	push   %ebx
 45c:	e8 3d 02 00 00       	call   69e <close>
 461:	83 c4 10             	add    $0x10,%esp

}
 464:	8d 65 f4             	lea    -0xc(%ebp),%esp
 467:	5b                   	pop    %ebx
 468:	5e                   	pop    %esi
 469:	5f                   	pop    %edi
 46a:	5d                   	pop    %ebp
 46b:	c3                   	ret    
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 470:	83 ec 04             	sub    $0x4,%esp
 473:	ff 75 08             	pushl  0x8(%ebp)
 476:	68 7b 0b 00 00       	push   $0xb7b
 47b:	6a 02                	push   $0x2
 47d:	e8 8e 03 00 00       	call   810 <printf>
    return;
 482:	83 c4 10             	add    $0x10,%esp
}
 485:	8d 65 f4             	lea    -0xc(%ebp),%esp
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5f                   	pop    %edi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 490:	83 ec 0c             	sub    $0xc,%esp
 493:	ff 75 08             	pushl  0x8(%ebp)
 496:	e8 55 fc ff ff       	call   f0 <strlen>
 49b:	83 c0 10             	add    $0x10,%eax
 49e:	83 c4 10             	add    $0x10,%esp
 4a1:	3d 00 02 00 00       	cmp    $0x200,%eax
 4a6:	0f 86 7c 00 00 00    	jbe    528 <ls+0x148>
      printf(1, "ls: path too long\n");
 4ac:	83 ec 08             	sub    $0x8,%esp
 4af:	68 b3 0b 00 00       	push   $0xbb3
 4b4:	6a 01                	push   $0x1
 4b6:	e8 55 03 00 00       	call   810 <printf>
      break;
 4bb:	83 c4 10             	add    $0x10,%esp
 4be:	eb 98                	jmp    458 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 4cc:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 4d2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 4d8:	e8 63 fe ff ff       	call   340 <fmtname>
 4dd:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4e3:	83 c4 0c             	add    $0xc,%esp
 4e6:	52                   	push   %edx
 4e7:	57                   	push   %edi
 4e8:	56                   	push   %esi
 4e9:	6a 02                	push   $0x2
 4eb:	50                   	push   %eax
 4ec:	68 a3 0b 00 00       	push   $0xba3
 4f1:	6a 01                	push   $0x1
 4f3:	e8 18 03 00 00       	call   810 <printf>
    break;
 4f8:	83 c4 20             	add    $0x20,%esp
 4fb:	e9 58 ff ff ff       	jmp    458 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 500:	83 ec 04             	sub    $0x4,%esp
 503:	ff 75 08             	pushl  0x8(%ebp)
 506:	68 8f 0b 00 00       	push   $0xb8f
 50b:	6a 02                	push   $0x2
 50d:	e8 fe 02 00 00       	call   810 <printf>
    close(fd);
 512:	89 1c 24             	mov    %ebx,(%esp)
 515:	e8 84 01 00 00       	call   69e <close>
    return;
 51a:	83 c4 10             	add    $0x10,%esp
}
 51d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 520:	5b                   	pop    %ebx
 521:	5e                   	pop    %esi
 522:	5f                   	pop    %edi
 523:	5d                   	pop    %ebp
 524:	c3                   	ret    
 525:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 528:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 52e:	83 ec 08             	sub    $0x8,%esp
 531:	ff 75 08             	pushl  0x8(%ebp)
 534:	50                   	push   %eax
 535:	e8 36 fb ff ff       	call   70 <strcpy>
    p = buf+strlen(buf);
 53a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 540:	89 04 24             	mov    %eax,(%esp)
 543:	e8 a8 fb ff ff       	call   f0 <strlen>
 548:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 54e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 551:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 553:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 556:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 55c:	c6 00 2f             	movb   $0x2f,(%eax)
 55f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 565:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 568:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 56e:	83 ec 04             	sub    $0x4,%esp
 571:	6a 10                	push   $0x10
 573:	50                   	push   %eax
 574:	53                   	push   %ebx
 575:	e8 14 01 00 00       	call   68e <read>
 57a:	83 c4 10             	add    $0x10,%esp
 57d:	83 f8 10             	cmp    $0x10,%eax
 580:	0f 85 d2 fe ff ff    	jne    458 <ls+0x78>
      if(de.inum == 0)
 586:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 58d:	00 
 58e:	74 d8                	je     568 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 590:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 596:	83 ec 04             	sub    $0x4,%esp
 599:	6a 0e                	push   $0xe
 59b:	50                   	push   %eax
 59c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 5a2:	e8 e9 fc ff ff       	call   290 <memmove>
      p[DIRSIZ] = 0;
 5a7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 5ad:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 5b1:	58                   	pop    %eax
 5b2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5b8:	5a                   	pop    %edx
 5b9:	56                   	push   %esi
 5ba:	50                   	push   %eax
 5bb:	e8 40 fc ff ff       	call   200 <stat>
 5c0:	83 c4 10             	add    $0x10,%esp
 5c3:	85 c0                	test   %eax,%eax
 5c5:	0f 88 85 00 00 00    	js     650 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 5cb:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 5d1:	8d 42 01             	lea    0x1(%edx),%eax
 5d4:	83 f8 01             	cmp    $0x1,%eax
 5d7:	76 04                	jbe    5dd <ls+0x1fd>
 5d9:	39 fa                	cmp    %edi,%edx
 5db:	75 8b                	jne    568 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 5dd:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 5e3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 5e9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 5ef:	83 ec 0c             	sub    $0xc,%esp
 5f2:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 5f8:	52                   	push   %edx
 5f9:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 5ff:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 606:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 60c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 612:	e8 29 fd ff ff       	call   340 <fmtname>
 617:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 61d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 623:	83 c4 0c             	add    $0xc,%esp
 626:	52                   	push   %edx
 627:	51                   	push   %ecx
 628:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 62e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 634:	50                   	push   %eax
 635:	68 a3 0b 00 00       	push   $0xba3
 63a:	6a 01                	push   $0x1
 63c:	e8 cf 01 00 00       	call   810 <printf>
 641:	83 c4 20             	add    $0x20,%esp
 644:	e9 1f ff ff ff       	jmp    568 <ls+0x188>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 650:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 656:	83 ec 04             	sub    $0x4,%esp
 659:	50                   	push   %eax
 65a:	68 8f 0b 00 00       	push   $0xb8f
 65f:	6a 01                	push   $0x1
 661:	e8 aa 01 00 00       	call   810 <printf>
        continue;
 666:	83 c4 10             	add    $0x10,%esp
 669:	e9 fa fe ff ff       	jmp    568 <ls+0x188>

0000066e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 66e:	b8 01 00 00 00       	mov    $0x1,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <exit>:
SYSCALL(exit)
 676:	b8 02 00 00 00       	mov    $0x2,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <wait>:
SYSCALL(wait)
 67e:	b8 03 00 00 00       	mov    $0x3,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <pipe>:
SYSCALL(pipe)
 686:	b8 04 00 00 00       	mov    $0x4,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <read>:
SYSCALL(read)
 68e:	b8 05 00 00 00       	mov    $0x5,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <write>:
SYSCALL(write)
 696:	b8 10 00 00 00       	mov    $0x10,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <close>:
SYSCALL(close)
 69e:	b8 15 00 00 00       	mov    $0x15,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <kill>:
SYSCALL(kill)
 6a6:	b8 06 00 00 00       	mov    $0x6,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <exec>:
SYSCALL(exec)
 6ae:	b8 07 00 00 00       	mov    $0x7,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <open>:
SYSCALL(open)
 6b6:	b8 0f 00 00 00       	mov    $0xf,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <mknod>:
SYSCALL(mknod)
 6be:	b8 11 00 00 00       	mov    $0x11,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <unlink>:
SYSCALL(unlink)
 6c6:	b8 12 00 00 00       	mov    $0x12,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <fstat>:
SYSCALL(fstat)
 6ce:	b8 08 00 00 00       	mov    $0x8,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <link>:
SYSCALL(link)
 6d6:	b8 13 00 00 00       	mov    $0x13,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <mkdir>:
SYSCALL(mkdir)
 6de:	b8 14 00 00 00       	mov    $0x14,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <chdir>:
SYSCALL(chdir)
 6e6:	b8 09 00 00 00       	mov    $0x9,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <dup>:
SYSCALL(dup)
 6ee:	b8 0a 00 00 00       	mov    $0xa,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <getpid>:
SYSCALL(getpid)
 6f6:	b8 0b 00 00 00       	mov    $0xb,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <sbrk>:
SYSCALL(sbrk)
 6fe:	b8 0c 00 00 00       	mov    $0xc,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <sleep>:
SYSCALL(sleep)
 706:	b8 0d 00 00 00       	mov    $0xd,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <uptime>:
SYSCALL(uptime)
 70e:	b8 0e 00 00 00       	mov    $0xe,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <halt>:
SYSCALL(halt)
 716:	b8 16 00 00 00       	mov    $0x16,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <toggle>:
SYSCALL(toggle)
 71e:	b8 17 00 00 00       	mov    $0x17,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <ps>:
SYSCALL(ps)
 726:	b8 18 00 00 00       	mov    $0x18,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <create_container>:
SYSCALL(create_container)
 72e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <destroy_container>:
SYSCALL(destroy_container)
 736:	b8 19 00 00 00       	mov    $0x19,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <join_container>:
SYSCALL(join_container)
 73e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <leave_container>:
SYSCALL(leave_container)
 746:	b8 1b 00 00 00       	mov    $0x1b,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <send>:
SYSCALL(send)
 74e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <recv>:
SYSCALL(recv)
 756:	b8 1e 00 00 00       	mov    $0x1e,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <getcid>:
SYSCALL(getcid)
 75e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 779:	85 d2                	test   %edx,%edx
{
 77b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 77e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 780:	79 76                	jns    7f8 <printint+0x88>
 782:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 786:	74 70                	je     7f8 <printint+0x88>
    x = -xx;
 788:	f7 d8                	neg    %eax
    neg = 1;
 78a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 791:	31 f6                	xor    %esi,%esi
 793:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 796:	eb 0a                	jmp    7a2 <printint+0x32>
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 7a0:	89 fe                	mov    %edi,%esi
 7a2:	31 d2                	xor    %edx,%edx
 7a4:	8d 7e 01             	lea    0x1(%esi),%edi
 7a7:	f7 f1                	div    %ecx
 7a9:	0f b6 92 d0 0b 00 00 	movzbl 0xbd0(%edx),%edx
  }while((x /= base) != 0);
 7b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7b5:	75 e9                	jne    7a0 <printint+0x30>
  if(neg)
 7b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7ba:	85 c0                	test   %eax,%eax
 7bc:	74 08                	je     7c6 <printint+0x56>
    buf[i++] = '-';
 7be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7c3:	8d 7e 02             	lea    0x2(%esi),%edi
 7c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
 7d0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7d3:	83 ec 04             	sub    $0x4,%esp
 7d6:	83 ee 01             	sub    $0x1,%esi
 7d9:	6a 01                	push   $0x1
 7db:	53                   	push   %ebx
 7dc:	57                   	push   %edi
 7dd:	88 45 d7             	mov    %al,-0x29(%ebp)
 7e0:	e8 b1 fe ff ff       	call   696 <write>

  while(--i >= 0)
 7e5:	83 c4 10             	add    $0x10,%esp
 7e8:	39 de                	cmp    %ebx,%esi
 7ea:	75 e4                	jne    7d0 <printint+0x60>
    putc(fd, buf[i]);
}
 7ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7ef:	5b                   	pop    %ebx
 7f0:	5e                   	pop    %esi
 7f1:	5f                   	pop    %edi
 7f2:	5d                   	pop    %ebp
 7f3:	c3                   	ret    
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7f8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7ff:	eb 90                	jmp    791 <printint+0x21>
 801:	eb 0d                	jmp    810 <printf>
 803:	90                   	nop
 804:	90                   	nop
 805:	90                   	nop
 806:	90                   	nop
 807:	90                   	nop
 808:	90                   	nop
 809:	90                   	nop
 80a:	90                   	nop
 80b:	90                   	nop
 80c:	90                   	nop
 80d:	90                   	nop
 80e:	90                   	nop
 80f:	90                   	nop

00000810 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 819:	8b 75 0c             	mov    0xc(%ebp),%esi
 81c:	0f b6 1e             	movzbl (%esi),%ebx
 81f:	84 db                	test   %bl,%bl
 821:	0f 84 b3 00 00 00    	je     8da <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 827:	8d 45 10             	lea    0x10(%ebp),%eax
 82a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 82d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 82f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 832:	eb 2f                	jmp    863 <printf+0x53>
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 838:	83 f8 25             	cmp    $0x25,%eax
 83b:	0f 84 a7 00 00 00    	je     8e8 <printf+0xd8>
  write(fd, &c, 1);
 841:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 844:	83 ec 04             	sub    $0x4,%esp
 847:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 84a:	6a 01                	push   $0x1
 84c:	50                   	push   %eax
 84d:	ff 75 08             	pushl  0x8(%ebp)
 850:	e8 41 fe ff ff       	call   696 <write>
 855:	83 c4 10             	add    $0x10,%esp
 858:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 85b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 85f:	84 db                	test   %bl,%bl
 861:	74 77                	je     8da <printf+0xca>
    if(state == 0){
 863:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 865:	0f be cb             	movsbl %bl,%ecx
 868:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 86b:	74 cb                	je     838 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 86d:	83 ff 25             	cmp    $0x25,%edi
 870:	75 e6                	jne    858 <printf+0x48>
      if(c == 'd'){
 872:	83 f8 64             	cmp    $0x64,%eax
 875:	0f 84 05 01 00 00    	je     980 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 87b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 881:	83 f9 70             	cmp    $0x70,%ecx
 884:	74 72                	je     8f8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 886:	83 f8 73             	cmp    $0x73,%eax
 889:	0f 84 99 00 00 00    	je     928 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 88f:	83 f8 63             	cmp    $0x63,%eax
 892:	0f 84 08 01 00 00    	je     9a0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 898:	83 f8 25             	cmp    $0x25,%eax
 89b:	0f 84 ef 00 00 00    	je     990 <printf+0x180>
  write(fd, &c, 1);
 8a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8a4:	83 ec 04             	sub    $0x4,%esp
 8a7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8ab:	6a 01                	push   $0x1
 8ad:	50                   	push   %eax
 8ae:	ff 75 08             	pushl  0x8(%ebp)
 8b1:	e8 e0 fd ff ff       	call   696 <write>
 8b6:	83 c4 0c             	add    $0xc,%esp
 8b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8bc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8bf:	6a 01                	push   $0x1
 8c1:	50                   	push   %eax
 8c2:	ff 75 08             	pushl  0x8(%ebp)
 8c5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8c8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8ca:	e8 c7 fd ff ff       	call   696 <write>
  for(i = 0; fmt[i]; i++){
 8cf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8d6:	84 db                	test   %bl,%bl
 8d8:	75 89                	jne    863 <printf+0x53>
    }
  }
}
 8da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8dd:	5b                   	pop    %ebx
 8de:	5e                   	pop    %esi
 8df:	5f                   	pop    %edi
 8e0:	5d                   	pop    %ebp
 8e1:	c3                   	ret    
 8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8e8:	bf 25 00 00 00       	mov    $0x25,%edi
 8ed:	e9 66 ff ff ff       	jmp    858 <printf+0x48>
 8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8f8:	83 ec 0c             	sub    $0xc,%esp
 8fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 900:	6a 00                	push   $0x0
 902:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 905:	8b 45 08             	mov    0x8(%ebp),%eax
 908:	8b 17                	mov    (%edi),%edx
 90a:	e8 61 fe ff ff       	call   770 <printint>
        ap++;
 90f:	89 f8                	mov    %edi,%eax
 911:	83 c4 10             	add    $0x10,%esp
      state = 0;
 914:	31 ff                	xor    %edi,%edi
        ap++;
 916:	83 c0 04             	add    $0x4,%eax
 919:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 91c:	e9 37 ff ff ff       	jmp    858 <printf+0x48>
 921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 928:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 92b:	8b 08                	mov    (%eax),%ecx
        ap++;
 92d:	83 c0 04             	add    $0x4,%eax
 930:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 933:	85 c9                	test   %ecx,%ecx
 935:	0f 84 8e 00 00 00    	je     9c9 <printf+0x1b9>
        while(*s != 0){
 93b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 93e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 940:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 942:	84 c0                	test   %al,%al
 944:	0f 84 0e ff ff ff    	je     858 <printf+0x48>
 94a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 94d:	89 de                	mov    %ebx,%esi
 94f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 952:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 955:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 958:	83 ec 04             	sub    $0x4,%esp
          s++;
 95b:	83 c6 01             	add    $0x1,%esi
 95e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 961:	6a 01                	push   $0x1
 963:	57                   	push   %edi
 964:	53                   	push   %ebx
 965:	e8 2c fd ff ff       	call   696 <write>
        while(*s != 0){
 96a:	0f b6 06             	movzbl (%esi),%eax
 96d:	83 c4 10             	add    $0x10,%esp
 970:	84 c0                	test   %al,%al
 972:	75 e4                	jne    958 <printf+0x148>
 974:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 977:	31 ff                	xor    %edi,%edi
 979:	e9 da fe ff ff       	jmp    858 <printf+0x48>
 97e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 980:	83 ec 0c             	sub    $0xc,%esp
 983:	b9 0a 00 00 00       	mov    $0xa,%ecx
 988:	6a 01                	push   $0x1
 98a:	e9 73 ff ff ff       	jmp    902 <printf+0xf2>
 98f:	90                   	nop
  write(fd, &c, 1);
 990:	83 ec 04             	sub    $0x4,%esp
 993:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 996:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 999:	6a 01                	push   $0x1
 99b:	e9 21 ff ff ff       	jmp    8c1 <printf+0xb1>
        putc(fd, *ap);
 9a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 9a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9a6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 9a8:	6a 01                	push   $0x1
        ap++;
 9aa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 9ad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9b3:	50                   	push   %eax
 9b4:	ff 75 08             	pushl  0x8(%ebp)
 9b7:	e8 da fc ff ff       	call   696 <write>
        ap++;
 9bc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9bf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9c2:	31 ff                	xor    %edi,%edi
 9c4:	e9 8f fe ff ff       	jmp    858 <printf+0x48>
          s = "(null)";
 9c9:	bb c6 0b 00 00       	mov    $0xbc6,%ebx
        while(*s != 0){
 9ce:	b8 28 00 00 00       	mov    $0x28,%eax
 9d3:	e9 72 ff ff ff       	jmp    94a <printf+0x13a>
 9d8:	66 90                	xchg   %ax,%ax
 9da:	66 90                	xchg   %ax,%ax
 9dc:	66 90                	xchg   %ax,%ax
 9de:	66 90                	xchg   %ax,%ax

000009e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e1:	a1 50 0f 00 00       	mov    0xf50,%eax
{
 9e6:	89 e5                	mov    %esp,%ebp
 9e8:	57                   	push   %edi
 9e9:	56                   	push   %esi
 9ea:	53                   	push   %ebx
 9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f8:	39 c8                	cmp    %ecx,%eax
 9fa:	8b 10                	mov    (%eax),%edx
 9fc:	73 32                	jae    a30 <free+0x50>
 9fe:	39 d1                	cmp    %edx,%ecx
 a00:	72 04                	jb     a06 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a02:	39 d0                	cmp    %edx,%eax
 a04:	72 32                	jb     a38 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a06:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a09:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a0c:	39 fa                	cmp    %edi,%edx
 a0e:	74 30                	je     a40 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a10:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a13:	8b 50 04             	mov    0x4(%eax),%edx
 a16:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a19:	39 f1                	cmp    %esi,%ecx
 a1b:	74 3a                	je     a57 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a1d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a1f:	a3 50 0f 00 00       	mov    %eax,0xf50
}
 a24:	5b                   	pop    %ebx
 a25:	5e                   	pop    %esi
 a26:	5f                   	pop    %edi
 a27:	5d                   	pop    %ebp
 a28:	c3                   	ret    
 a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a30:	39 d0                	cmp    %edx,%eax
 a32:	72 04                	jb     a38 <free+0x58>
 a34:	39 d1                	cmp    %edx,%ecx
 a36:	72 ce                	jb     a06 <free+0x26>
{
 a38:	89 d0                	mov    %edx,%eax
 a3a:	eb bc                	jmp    9f8 <free+0x18>
 a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a40:	03 72 04             	add    0x4(%edx),%esi
 a43:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a46:	8b 10                	mov    (%eax),%edx
 a48:	8b 12                	mov    (%edx),%edx
 a4a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a4d:	8b 50 04             	mov    0x4(%eax),%edx
 a50:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a53:	39 f1                	cmp    %esi,%ecx
 a55:	75 c6                	jne    a1d <free+0x3d>
    p->s.size += bp->s.size;
 a57:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a5a:	a3 50 0f 00 00       	mov    %eax,0xf50
    p->s.size += bp->s.size;
 a5f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a62:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a65:	89 10                	mov    %edx,(%eax)
}
 a67:	5b                   	pop    %ebx
 a68:	5e                   	pop    %esi
 a69:	5f                   	pop    %edi
 a6a:	5d                   	pop    %ebp
 a6b:	c3                   	ret    
 a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a7c:	8b 15 50 0f 00 00    	mov    0xf50,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a82:	8d 78 07             	lea    0x7(%eax),%edi
 a85:	c1 ef 03             	shr    $0x3,%edi
 a88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a8b:	85 d2                	test   %edx,%edx
 a8d:	0f 84 9d 00 00 00    	je     b30 <malloc+0xc0>
 a93:	8b 02                	mov    (%edx),%eax
 a95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a98:	39 cf                	cmp    %ecx,%edi
 a9a:	76 6c                	jbe    b08 <malloc+0x98>
 a9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 aa2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 aa7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 aaa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ab1:	eb 0e                	jmp    ac1 <malloc+0x51>
 ab3:	90                   	nop
 ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aba:	8b 48 04             	mov    0x4(%eax),%ecx
 abd:	39 f9                	cmp    %edi,%ecx
 abf:	73 47                	jae    b08 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ac1:	39 05 50 0f 00 00    	cmp    %eax,0xf50
 ac7:	89 c2                	mov    %eax,%edx
 ac9:	75 ed                	jne    ab8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 acb:	83 ec 0c             	sub    $0xc,%esp
 ace:	56                   	push   %esi
 acf:	e8 2a fc ff ff       	call   6fe <sbrk>
  if(p == (char*)-1)
 ad4:	83 c4 10             	add    $0x10,%esp
 ad7:	83 f8 ff             	cmp    $0xffffffff,%eax
 ada:	74 1c                	je     af8 <malloc+0x88>
  hp->s.size = nu;
 adc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 adf:	83 ec 0c             	sub    $0xc,%esp
 ae2:	83 c0 08             	add    $0x8,%eax
 ae5:	50                   	push   %eax
 ae6:	e8 f5 fe ff ff       	call   9e0 <free>
  return freep;
 aeb:	8b 15 50 0f 00 00    	mov    0xf50,%edx
      if((p = morecore(nunits)) == 0)
 af1:	83 c4 10             	add    $0x10,%esp
 af4:	85 d2                	test   %edx,%edx
 af6:	75 c0                	jne    ab8 <malloc+0x48>
        return 0;
  }
}
 af8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 afb:	31 c0                	xor    %eax,%eax
}
 afd:	5b                   	pop    %ebx
 afe:	5e                   	pop    %esi
 aff:	5f                   	pop    %edi
 b00:	5d                   	pop    %ebp
 b01:	c3                   	ret    
 b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b08:	39 cf                	cmp    %ecx,%edi
 b0a:	74 54                	je     b60 <malloc+0xf0>
        p->s.size -= nunits;
 b0c:	29 f9                	sub    %edi,%ecx
 b0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b17:	89 15 50 0f 00 00    	mov    %edx,0xf50
}
 b1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b20:	83 c0 08             	add    $0x8,%eax
}
 b23:	5b                   	pop    %ebx
 b24:	5e                   	pop    %esi
 b25:	5f                   	pop    %edi
 b26:	5d                   	pop    %ebp
 b27:	c3                   	ret    
 b28:	90                   	nop
 b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b30:	c7 05 50 0f 00 00 54 	movl   $0xf54,0xf50
 b37:	0f 00 00 
 b3a:	c7 05 54 0f 00 00 54 	movl   $0xf54,0xf54
 b41:	0f 00 00 
    base.s.size = 0;
 b44:	b8 54 0f 00 00       	mov    $0xf54,%eax
 b49:	c7 05 58 0f 00 00 00 	movl   $0x0,0xf58
 b50:	00 00 00 
 b53:	e9 44 ff ff ff       	jmp    a9c <malloc+0x2c>
 b58:	90                   	nop
 b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b60:	8b 08                	mov    (%eax),%ecx
 b62:	89 0a                	mov    %ecx,(%edx)
 b64:	eb b1                	jmp    b17 <malloc+0xa7>
