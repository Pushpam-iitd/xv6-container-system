
_mkdir:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bf 01 00 00 00       	mov    $0x1,%edi
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d 76 00             	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 b4 06 00 00       	call   6ee <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 36 06 00 00       	call   686 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 8f 0b 00 00       	push   $0xb8f
  58:	6a 02                	push   $0x2
  5a:	e8 c1 07 00 00       	call   820 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 78 0b 00 00       	push   $0xb78
  6b:	6a 02                	push   $0x2
  6d:	e8 ae 07 00 00       	call   820 <printf>
    exit();
  72:	e8 0f 06 00 00       	call   686 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e4:	29 d8                	sub    %ebx,%eax
}
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
{
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 e6 04 00 00       	call   69e <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 a4 04 00 00       	call   6c6 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 a7 04 00 00       	call   6de <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 6d 04 00 00       	call   6ae <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
  return vdst;
}
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    
 2ca:	66 90                	xchg   %ax,%ax
 2cc:	66 90                	xchg   %ax,%ax
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 2d8:	31 db                	xor    %ebx,%ebx
{
 2da:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 2dd:	80 39 00             	cmpb   $0x0,(%ecx)
 2e0:	0f b6 02             	movzbl (%edx),%eax
 2e3:	74 33                	je     318 <mystrcmp+0x48>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
 2e8:	83 c1 01             	add    $0x1,%ecx
 2eb:	83 c3 01             	add    $0x1,%ebx
 2ee:	80 39 00             	cmpb   $0x0,(%ecx)
 2f1:	75 f5                	jne    2e8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 2f3:	84 c0                	test   %al,%al
 2f5:	74 51                	je     348 <mystrcmp+0x78>
    int a =0,b=0;
 2f7:	31 f6                	xor    %esi,%esi
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 300:	83 c2 01             	add    $0x1,%edx
 303:	83 c6 01             	add    $0x1,%esi
 306:	80 3a 00             	cmpb   $0x0,(%edx)
 309:	75 f5                	jne    300 <mystrcmp+0x30>

    if(a!=b)return 0;
 30b:	31 c0                	xor    %eax,%eax
 30d:	39 de                	cmp    %ebx,%esi
 30f:	74 0f                	je     320 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 311:	5b                   	pop    %ebx
 312:	5e                   	pop    %esi
 313:	5d                   	pop    %ebp
 314:	c3                   	ret    
 315:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 318:	84 c0                	test   %al,%al
 31a:	75 db                	jne    2f7 <mystrcmp+0x27>
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 320:	01 d3                	add    %edx,%ebx
 322:	eb 13                	jmp    337 <mystrcmp+0x67>
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 328:	83 c2 01             	add    $0x1,%edx
 32b:	83 c1 01             	add    $0x1,%ecx
 32e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 332:	38 41 ff             	cmp    %al,-0x1(%ecx)
 335:	75 11                	jne    348 <mystrcmp+0x78>
    while(a--){
 337:	39 d3                	cmp    %edx,%ebx
 339:	75 ed                	jne    328 <mystrcmp+0x58>
}
 33b:	5b                   	pop    %ebx
    return 1;
 33c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 341:	5e                   	pop    %esi
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 348:	5b                   	pop    %ebx
    if(a!=b)return 0;
 349:	31 c0                	xor    %eax,%eax
}
 34b:	5e                   	pop    %esi
 34c:	5d                   	pop    %ebp
 34d:	c3                   	ret    
 34e:	66 90                	xchg   %ax,%ax

00000350 <fmtname>:

char*
fmtname(char *path)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 358:	83 ec 0c             	sub    $0xc,%esp
 35b:	53                   	push   %ebx
 35c:	e8 9f fd ff ff       	call   100 <strlen>
 361:	83 c4 10             	add    $0x10,%esp
 364:	01 d8                	add    %ebx,%eax
 366:	73 0f                	jae    377 <fmtname+0x27>
 368:	eb 12                	jmp    37c <fmtname+0x2c>
 36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 370:	83 e8 01             	sub    $0x1,%eax
 373:	39 c3                	cmp    %eax,%ebx
 375:	77 05                	ja     37c <fmtname+0x2c>
 377:	80 38 2f             	cmpb   $0x2f,(%eax)
 37a:	75 f4                	jne    370 <fmtname+0x20>
    ;
  p++;
 37c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 37f:	83 ec 0c             	sub    $0xc,%esp
 382:	53                   	push   %ebx
 383:	e8 78 fd ff ff       	call   100 <strlen>
 388:	83 c4 10             	add    $0x10,%esp
 38b:	83 f8 0d             	cmp    $0xd,%eax
 38e:	77 4a                	ja     3da <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 390:	83 ec 0c             	sub    $0xc,%esp
 393:	53                   	push   %ebx
 394:	e8 67 fd ff ff       	call   100 <strlen>
 399:	83 c4 0c             	add    $0xc,%esp
 39c:	50                   	push   %eax
 39d:	53                   	push   %ebx
 39e:	68 80 0f 00 00       	push   $0xf80
 3a3:	e8 f8 fe ff ff       	call   2a0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3a8:	89 1c 24             	mov    %ebx,(%esp)
 3ab:	e8 50 fd ff ff       	call   100 <strlen>
 3b0:	89 1c 24             	mov    %ebx,(%esp)
 3b3:	89 c6                	mov    %eax,%esi
  return buf;
 3b5:	bb 80 0f 00 00       	mov    $0xf80,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3ba:	e8 41 fd ff ff       	call   100 <strlen>
 3bf:	ba 0e 00 00 00       	mov    $0xe,%edx
 3c4:	83 c4 0c             	add    $0xc,%esp
 3c7:	05 80 0f 00 00       	add    $0xf80,%eax
 3cc:	29 f2                	sub    %esi,%edx
 3ce:	52                   	push   %edx
 3cf:	6a 20                	push   $0x20
 3d1:	50                   	push   %eax
 3d2:	e8 59 fd ff ff       	call   130 <memset>
  return buf;
 3d7:	83 c4 10             	add    $0x10,%esp
}
 3da:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3dd:	89 d8                	mov    %ebx,%eax
 3df:	5b                   	pop    %ebx
 3e0:	5e                   	pop    %esi
 3e1:	5d                   	pop    %ebp
 3e2:	c3                   	ret    
 3e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <ls>:

void
ls(char *path)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 3fc:	e8 6d 03 00 00       	call   76e <getcid>

  printf(2, "Cid is: %d\n", cid);
 401:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 404:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 406:	50                   	push   %eax
 407:	68 ab 0b 00 00       	push   $0xbab
 40c:	6a 02                	push   $0x2
 40e:	e8 0d 04 00 00       	call   820 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 413:	59                   	pop    %ecx
 414:	5b                   	pop    %ebx
 415:	6a 00                	push   $0x0
 417:	ff 75 08             	pushl  0x8(%ebp)
 41a:	e8 a7 02 00 00       	call   6c6 <open>
 41f:	83 c4 10             	add    $0x10,%esp
 422:	85 c0                	test   %eax,%eax
 424:	78 5a                	js     480 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 426:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 42c:	83 ec 08             	sub    $0x8,%esp
 42f:	89 c3                	mov    %eax,%ebx
 431:	56                   	push   %esi
 432:	50                   	push   %eax
 433:	e8 a6 02 00 00       	call   6de <fstat>
 438:	83 c4 10             	add    $0x10,%esp
 43b:	85 c0                	test   %eax,%eax
 43d:	0f 88 cd 00 00 00    	js     510 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 443:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 44a:	66 83 f8 01          	cmp    $0x1,%ax
 44e:	74 50                	je     4a0 <ls+0xb0>
 450:	66 83 f8 02          	cmp    $0x2,%ax
 454:	75 12                	jne    468 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 456:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 45c:	8d 42 01             	lea    0x1(%edx),%eax
 45f:	83 f8 01             	cmp    $0x1,%eax
 462:	76 6c                	jbe    4d0 <ls+0xe0>
 464:	39 fa                	cmp    %edi,%edx
 466:	74 68                	je     4d0 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 468:	83 ec 0c             	sub    $0xc,%esp
 46b:	53                   	push   %ebx
 46c:	e8 3d 02 00 00       	call   6ae <close>
 471:	83 c4 10             	add    $0x10,%esp

}
 474:	8d 65 f4             	lea    -0xc(%ebp),%esp
 477:	5b                   	pop    %ebx
 478:	5e                   	pop    %esi
 479:	5f                   	pop    %edi
 47a:	5d                   	pop    %ebp
 47b:	c3                   	ret    
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 480:	83 ec 04             	sub    $0x4,%esp
 483:	ff 75 08             	pushl  0x8(%ebp)
 486:	68 b7 0b 00 00       	push   $0xbb7
 48b:	6a 02                	push   $0x2
 48d:	e8 8e 03 00 00       	call   820 <printf>
    return;
 492:	83 c4 10             	add    $0x10,%esp
}
 495:	8d 65 f4             	lea    -0xc(%ebp),%esp
 498:	5b                   	pop    %ebx
 499:	5e                   	pop    %esi
 49a:	5f                   	pop    %edi
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
 49d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 4a0:	83 ec 0c             	sub    $0xc,%esp
 4a3:	ff 75 08             	pushl  0x8(%ebp)
 4a6:	e8 55 fc ff ff       	call   100 <strlen>
 4ab:	83 c0 10             	add    $0x10,%eax
 4ae:	83 c4 10             	add    $0x10,%esp
 4b1:	3d 00 02 00 00       	cmp    $0x200,%eax
 4b6:	0f 86 7c 00 00 00    	jbe    538 <ls+0x148>
      printf(1, "ls: path too long\n");
 4bc:	83 ec 08             	sub    $0x8,%esp
 4bf:	68 ef 0b 00 00       	push   $0xbef
 4c4:	6a 01                	push   $0x1
 4c6:	e8 55 03 00 00       	call   820 <printf>
      break;
 4cb:	83 c4 10             	add    $0x10,%esp
 4ce:	eb 98                	jmp    468 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	ff 75 08             	pushl  0x8(%ebp)
 4d6:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 4dc:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 4e2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 4e8:	e8 63 fe ff ff       	call   350 <fmtname>
 4ed:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4f3:	83 c4 0c             	add    $0xc,%esp
 4f6:	52                   	push   %edx
 4f7:	57                   	push   %edi
 4f8:	56                   	push   %esi
 4f9:	6a 02                	push   $0x2
 4fb:	50                   	push   %eax
 4fc:	68 df 0b 00 00       	push   $0xbdf
 501:	6a 01                	push   $0x1
 503:	e8 18 03 00 00       	call   820 <printf>
    break;
 508:	83 c4 20             	add    $0x20,%esp
 50b:	e9 58 ff ff ff       	jmp    468 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	68 cb 0b 00 00       	push   $0xbcb
 51b:	6a 02                	push   $0x2
 51d:	e8 fe 02 00 00       	call   820 <printf>
    close(fd);
 522:	89 1c 24             	mov    %ebx,(%esp)
 525:	e8 84 01 00 00       	call   6ae <close>
    return;
 52a:	83 c4 10             	add    $0x10,%esp
}
 52d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 530:	5b                   	pop    %ebx
 531:	5e                   	pop    %esi
 532:	5f                   	pop    %edi
 533:	5d                   	pop    %ebp
 534:	c3                   	ret    
 535:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 538:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 53e:	83 ec 08             	sub    $0x8,%esp
 541:	ff 75 08             	pushl  0x8(%ebp)
 544:	50                   	push   %eax
 545:	e8 36 fb ff ff       	call   80 <strcpy>
    p = buf+strlen(buf);
 54a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 550:	89 04 24             	mov    %eax,(%esp)
 553:	e8 a8 fb ff ff       	call   100 <strlen>
 558:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 55e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 561:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 563:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 566:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 56c:	c6 00 2f             	movb   $0x2f,(%eax)
 56f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 575:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 578:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 57e:	83 ec 04             	sub    $0x4,%esp
 581:	6a 10                	push   $0x10
 583:	50                   	push   %eax
 584:	53                   	push   %ebx
 585:	e8 14 01 00 00       	call   69e <read>
 58a:	83 c4 10             	add    $0x10,%esp
 58d:	83 f8 10             	cmp    $0x10,%eax
 590:	0f 85 d2 fe ff ff    	jne    468 <ls+0x78>
      if(de.inum == 0)
 596:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 59d:	00 
 59e:	74 d8                	je     578 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 5a0:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 5a6:	83 ec 04             	sub    $0x4,%esp
 5a9:	6a 0e                	push   $0xe
 5ab:	50                   	push   %eax
 5ac:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 5b2:	e8 e9 fc ff ff       	call   2a0 <memmove>
      p[DIRSIZ] = 0;
 5b7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 5bd:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 5c1:	58                   	pop    %eax
 5c2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5c8:	5a                   	pop    %edx
 5c9:	56                   	push   %esi
 5ca:	50                   	push   %eax
 5cb:	e8 40 fc ff ff       	call   210 <stat>
 5d0:	83 c4 10             	add    $0x10,%esp
 5d3:	85 c0                	test   %eax,%eax
 5d5:	0f 88 85 00 00 00    	js     660 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 5db:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 5e1:	8d 42 01             	lea    0x1(%edx),%eax
 5e4:	83 f8 01             	cmp    $0x1,%eax
 5e7:	76 04                	jbe    5ed <ls+0x1fd>
 5e9:	39 fa                	cmp    %edi,%edx
 5eb:	75 8b                	jne    578 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 5ed:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 5f3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 5f9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 5ff:	83 ec 0c             	sub    $0xc,%esp
 602:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 608:	52                   	push   %edx
 609:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 60f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 616:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 61c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 622:	e8 29 fd ff ff       	call   350 <fmtname>
 627:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 62d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 633:	83 c4 0c             	add    $0xc,%esp
 636:	52                   	push   %edx
 637:	51                   	push   %ecx
 638:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 63e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 644:	50                   	push   %eax
 645:	68 df 0b 00 00       	push   $0xbdf
 64a:	6a 01                	push   $0x1
 64c:	e8 cf 01 00 00       	call   820 <printf>
 651:	83 c4 20             	add    $0x20,%esp
 654:	e9 1f ff ff ff       	jmp    578 <ls+0x188>
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 660:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 666:	83 ec 04             	sub    $0x4,%esp
 669:	50                   	push   %eax
 66a:	68 cb 0b 00 00       	push   $0xbcb
 66f:	6a 01                	push   $0x1
 671:	e8 aa 01 00 00       	call   820 <printf>
        continue;
 676:	83 c4 10             	add    $0x10,%esp
 679:	e9 fa fe ff ff       	jmp    578 <ls+0x188>

0000067e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 67e:	b8 01 00 00 00       	mov    $0x1,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <exit>:
SYSCALL(exit)
 686:	b8 02 00 00 00       	mov    $0x2,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <wait>:
SYSCALL(wait)
 68e:	b8 03 00 00 00       	mov    $0x3,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <pipe>:
SYSCALL(pipe)
 696:	b8 04 00 00 00       	mov    $0x4,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <read>:
SYSCALL(read)
 69e:	b8 05 00 00 00       	mov    $0x5,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <write>:
SYSCALL(write)
 6a6:	b8 10 00 00 00       	mov    $0x10,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <close>:
SYSCALL(close)
 6ae:	b8 15 00 00 00       	mov    $0x15,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <kill>:
SYSCALL(kill)
 6b6:	b8 06 00 00 00       	mov    $0x6,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <exec>:
SYSCALL(exec)
 6be:	b8 07 00 00 00       	mov    $0x7,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <open>:
SYSCALL(open)
 6c6:	b8 0f 00 00 00       	mov    $0xf,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <mknod>:
SYSCALL(mknod)
 6ce:	b8 11 00 00 00       	mov    $0x11,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <unlink>:
SYSCALL(unlink)
 6d6:	b8 12 00 00 00       	mov    $0x12,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <fstat>:
SYSCALL(fstat)
 6de:	b8 08 00 00 00       	mov    $0x8,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <link>:
SYSCALL(link)
 6e6:	b8 13 00 00 00       	mov    $0x13,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <mkdir>:
SYSCALL(mkdir)
 6ee:	b8 14 00 00 00       	mov    $0x14,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <chdir>:
SYSCALL(chdir)
 6f6:	b8 09 00 00 00       	mov    $0x9,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <dup>:
SYSCALL(dup)
 6fe:	b8 0a 00 00 00       	mov    $0xa,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <getpid>:
SYSCALL(getpid)
 706:	b8 0b 00 00 00       	mov    $0xb,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <sbrk>:
SYSCALL(sbrk)
 70e:	b8 0c 00 00 00       	mov    $0xc,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <sleep>:
SYSCALL(sleep)
 716:	b8 0d 00 00 00       	mov    $0xd,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <uptime>:
SYSCALL(uptime)
 71e:	b8 0e 00 00 00       	mov    $0xe,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <halt>:
SYSCALL(halt)
 726:	b8 16 00 00 00       	mov    $0x16,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <toggle>:
SYSCALL(toggle)
 72e:	b8 17 00 00 00       	mov    $0x17,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <ps>:
SYSCALL(ps)
 736:	b8 18 00 00 00       	mov    $0x18,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <create_container>:
SYSCALL(create_container)
 73e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <destroy_container>:
SYSCALL(destroy_container)
 746:	b8 19 00 00 00       	mov    $0x19,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <join_container>:
SYSCALL(join_container)
 74e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <leave_container>:
SYSCALL(leave_container)
 756:	b8 1b 00 00 00       	mov    $0x1b,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <send>:
SYSCALL(send)
 75e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    

00000766 <recv>:
SYSCALL(recv)
 766:	b8 1e 00 00 00       	mov    $0x1e,%eax
 76b:	cd 40                	int    $0x40
 76d:	c3                   	ret    

0000076e <getcid>:
SYSCALL(getcid)
 76e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 773:	cd 40                	int    $0x40
 775:	c3                   	ret    
 776:	66 90                	xchg   %ax,%ax
 778:	66 90                	xchg   %ax,%ax
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 789:	85 d2                	test   %edx,%edx
{
 78b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 78e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 790:	79 76                	jns    808 <printint+0x88>
 792:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 796:	74 70                	je     808 <printint+0x88>
    x = -xx;
 798:	f7 d8                	neg    %eax
    neg = 1;
 79a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 7a1:	31 f6                	xor    %esi,%esi
 7a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 7a6:	eb 0a                	jmp    7b2 <printint+0x32>
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 7b0:	89 fe                	mov    %edi,%esi
 7b2:	31 d2                	xor    %edx,%edx
 7b4:	8d 7e 01             	lea    0x1(%esi),%edi
 7b7:	f7 f1                	div    %ecx
 7b9:	0f b6 92 0c 0c 00 00 	movzbl 0xc0c(%edx),%edx
  }while((x /= base) != 0);
 7c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7c5:	75 e9                	jne    7b0 <printint+0x30>
  if(neg)
 7c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7ca:	85 c0                	test   %eax,%eax
 7cc:	74 08                	je     7d6 <printint+0x56>
    buf[i++] = '-';
 7ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7d3:	8d 7e 02             	lea    0x2(%esi),%edi
 7d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7da:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
 7e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7e3:	83 ec 04             	sub    $0x4,%esp
 7e6:	83 ee 01             	sub    $0x1,%esi
 7e9:	6a 01                	push   $0x1
 7eb:	53                   	push   %ebx
 7ec:	57                   	push   %edi
 7ed:	88 45 d7             	mov    %al,-0x29(%ebp)
 7f0:	e8 b1 fe ff ff       	call   6a6 <write>

  while(--i >= 0)
 7f5:	83 c4 10             	add    $0x10,%esp
 7f8:	39 de                	cmp    %ebx,%esi
 7fa:	75 e4                	jne    7e0 <printint+0x60>
    putc(fd, buf[i]);
}
 7fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7ff:	5b                   	pop    %ebx
 800:	5e                   	pop    %esi
 801:	5f                   	pop    %edi
 802:	5d                   	pop    %ebp
 803:	c3                   	ret    
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 808:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 80f:	eb 90                	jmp    7a1 <printint+0x21>
 811:	eb 0d                	jmp    820 <printf>
 813:	90                   	nop
 814:	90                   	nop
 815:	90                   	nop
 816:	90                   	nop
 817:	90                   	nop
 818:	90                   	nop
 819:	90                   	nop
 81a:	90                   	nop
 81b:	90                   	nop
 81c:	90                   	nop
 81d:	90                   	nop
 81e:	90                   	nop
 81f:	90                   	nop

00000820 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 829:	8b 75 0c             	mov    0xc(%ebp),%esi
 82c:	0f b6 1e             	movzbl (%esi),%ebx
 82f:	84 db                	test   %bl,%bl
 831:	0f 84 b3 00 00 00    	je     8ea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 837:	8d 45 10             	lea    0x10(%ebp),%eax
 83a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 83d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 83f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 842:	eb 2f                	jmp    873 <printf+0x53>
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 848:	83 f8 25             	cmp    $0x25,%eax
 84b:	0f 84 a7 00 00 00    	je     8f8 <printf+0xd8>
  write(fd, &c, 1);
 851:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 854:	83 ec 04             	sub    $0x4,%esp
 857:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 85a:	6a 01                	push   $0x1
 85c:	50                   	push   %eax
 85d:	ff 75 08             	pushl  0x8(%ebp)
 860:	e8 41 fe ff ff       	call   6a6 <write>
 865:	83 c4 10             	add    $0x10,%esp
 868:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 86b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 86f:	84 db                	test   %bl,%bl
 871:	74 77                	je     8ea <printf+0xca>
    if(state == 0){
 873:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 875:	0f be cb             	movsbl %bl,%ecx
 878:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 87b:	74 cb                	je     848 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 87d:	83 ff 25             	cmp    $0x25,%edi
 880:	75 e6                	jne    868 <printf+0x48>
      if(c == 'd'){
 882:	83 f8 64             	cmp    $0x64,%eax
 885:	0f 84 05 01 00 00    	je     990 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 88b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 891:	83 f9 70             	cmp    $0x70,%ecx
 894:	74 72                	je     908 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 896:	83 f8 73             	cmp    $0x73,%eax
 899:	0f 84 99 00 00 00    	je     938 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 89f:	83 f8 63             	cmp    $0x63,%eax
 8a2:	0f 84 08 01 00 00    	je     9b0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 8a8:	83 f8 25             	cmp    $0x25,%eax
 8ab:	0f 84 ef 00 00 00    	je     9a0 <printf+0x180>
  write(fd, &c, 1);
 8b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8b4:	83 ec 04             	sub    $0x4,%esp
 8b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8bb:	6a 01                	push   $0x1
 8bd:	50                   	push   %eax
 8be:	ff 75 08             	pushl  0x8(%ebp)
 8c1:	e8 e0 fd ff ff       	call   6a6 <write>
 8c6:	83 c4 0c             	add    $0xc,%esp
 8c9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8cc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8cf:	6a 01                	push   $0x1
 8d1:	50                   	push   %eax
 8d2:	ff 75 08             	pushl  0x8(%ebp)
 8d5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8d8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8da:	e8 c7 fd ff ff       	call   6a6 <write>
  for(i = 0; fmt[i]; i++){
 8df:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8e6:	84 db                	test   %bl,%bl
 8e8:	75 89                	jne    873 <printf+0x53>
    }
  }
}
 8ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ed:	5b                   	pop    %ebx
 8ee:	5e                   	pop    %esi
 8ef:	5f                   	pop    %edi
 8f0:	5d                   	pop    %ebp
 8f1:	c3                   	ret    
 8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8f8:	bf 25 00 00 00       	mov    $0x25,%edi
 8fd:	e9 66 ff ff ff       	jmp    868 <printf+0x48>
 902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 908:	83 ec 0c             	sub    $0xc,%esp
 90b:	b9 10 00 00 00       	mov    $0x10,%ecx
 910:	6a 00                	push   $0x0
 912:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 915:	8b 45 08             	mov    0x8(%ebp),%eax
 918:	8b 17                	mov    (%edi),%edx
 91a:	e8 61 fe ff ff       	call   780 <printint>
        ap++;
 91f:	89 f8                	mov    %edi,%eax
 921:	83 c4 10             	add    $0x10,%esp
      state = 0;
 924:	31 ff                	xor    %edi,%edi
        ap++;
 926:	83 c0 04             	add    $0x4,%eax
 929:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 92c:	e9 37 ff ff ff       	jmp    868 <printf+0x48>
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 938:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 93b:	8b 08                	mov    (%eax),%ecx
        ap++;
 93d:	83 c0 04             	add    $0x4,%eax
 940:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 943:	85 c9                	test   %ecx,%ecx
 945:	0f 84 8e 00 00 00    	je     9d9 <printf+0x1b9>
        while(*s != 0){
 94b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 94e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 950:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 952:	84 c0                	test   %al,%al
 954:	0f 84 0e ff ff ff    	je     868 <printf+0x48>
 95a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 95d:	89 de                	mov    %ebx,%esi
 95f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 962:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 965:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 968:	83 ec 04             	sub    $0x4,%esp
          s++;
 96b:	83 c6 01             	add    $0x1,%esi
 96e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 971:	6a 01                	push   $0x1
 973:	57                   	push   %edi
 974:	53                   	push   %ebx
 975:	e8 2c fd ff ff       	call   6a6 <write>
        while(*s != 0){
 97a:	0f b6 06             	movzbl (%esi),%eax
 97d:	83 c4 10             	add    $0x10,%esp
 980:	84 c0                	test   %al,%al
 982:	75 e4                	jne    968 <printf+0x148>
 984:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 987:	31 ff                	xor    %edi,%edi
 989:	e9 da fe ff ff       	jmp    868 <printf+0x48>
 98e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 990:	83 ec 0c             	sub    $0xc,%esp
 993:	b9 0a 00 00 00       	mov    $0xa,%ecx
 998:	6a 01                	push   $0x1
 99a:	e9 73 ff ff ff       	jmp    912 <printf+0xf2>
 99f:	90                   	nop
  write(fd, &c, 1);
 9a0:	83 ec 04             	sub    $0x4,%esp
 9a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 9a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 9a9:	6a 01                	push   $0x1
 9ab:	e9 21 ff ff ff       	jmp    8d1 <printf+0xb1>
        putc(fd, *ap);
 9b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 9b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9b6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 9b8:	6a 01                	push   $0x1
        ap++;
 9ba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 9bd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9c3:	50                   	push   %eax
 9c4:	ff 75 08             	pushl  0x8(%ebp)
 9c7:	e8 da fc ff ff       	call   6a6 <write>
        ap++;
 9cc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9cf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9d2:	31 ff                	xor    %edi,%edi
 9d4:	e9 8f fe ff ff       	jmp    868 <printf+0x48>
          s = "(null)";
 9d9:	bb 02 0c 00 00       	mov    $0xc02,%ebx
        while(*s != 0){
 9de:	b8 28 00 00 00       	mov    $0x28,%eax
 9e3:	e9 72 ff ff ff       	jmp    95a <printf+0x13a>
 9e8:	66 90                	xchg   %ax,%ax
 9ea:	66 90                	xchg   %ax,%ax
 9ec:	66 90                	xchg   %ax,%ax
 9ee:	66 90                	xchg   %ax,%ax

000009f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f1:	a1 90 0f 00 00       	mov    0xf90,%eax
{
 9f6:	89 e5                	mov    %esp,%ebp
 9f8:	57                   	push   %edi
 9f9:	56                   	push   %esi
 9fa:	53                   	push   %ebx
 9fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a08:	39 c8                	cmp    %ecx,%eax
 a0a:	8b 10                	mov    (%eax),%edx
 a0c:	73 32                	jae    a40 <free+0x50>
 a0e:	39 d1                	cmp    %edx,%ecx
 a10:	72 04                	jb     a16 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a12:	39 d0                	cmp    %edx,%eax
 a14:	72 32                	jb     a48 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a16:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a19:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a1c:	39 fa                	cmp    %edi,%edx
 a1e:	74 30                	je     a50 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a20:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a23:	8b 50 04             	mov    0x4(%eax),%edx
 a26:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a29:	39 f1                	cmp    %esi,%ecx
 a2b:	74 3a                	je     a67 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a2d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a2f:	a3 90 0f 00 00       	mov    %eax,0xf90
}
 a34:	5b                   	pop    %ebx
 a35:	5e                   	pop    %esi
 a36:	5f                   	pop    %edi
 a37:	5d                   	pop    %ebp
 a38:	c3                   	ret    
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a40:	39 d0                	cmp    %edx,%eax
 a42:	72 04                	jb     a48 <free+0x58>
 a44:	39 d1                	cmp    %edx,%ecx
 a46:	72 ce                	jb     a16 <free+0x26>
{
 a48:	89 d0                	mov    %edx,%eax
 a4a:	eb bc                	jmp    a08 <free+0x18>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a50:	03 72 04             	add    0x4(%edx),%esi
 a53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a56:	8b 10                	mov    (%eax),%edx
 a58:	8b 12                	mov    (%edx),%edx
 a5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a5d:	8b 50 04             	mov    0x4(%eax),%edx
 a60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a63:	39 f1                	cmp    %esi,%ecx
 a65:	75 c6                	jne    a2d <free+0x3d>
    p->s.size += bp->s.size;
 a67:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a6a:	a3 90 0f 00 00       	mov    %eax,0xf90
    p->s.size += bp->s.size;
 a6f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a72:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a75:	89 10                	mov    %edx,(%eax)
}
 a77:	5b                   	pop    %ebx
 a78:	5e                   	pop    %esi
 a79:	5f                   	pop    %edi
 a7a:	5d                   	pop    %ebp
 a7b:	c3                   	ret    
 a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	57                   	push   %edi
 a84:	56                   	push   %esi
 a85:	53                   	push   %ebx
 a86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a8c:	8b 15 90 0f 00 00    	mov    0xf90,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a92:	8d 78 07             	lea    0x7(%eax),%edi
 a95:	c1 ef 03             	shr    $0x3,%edi
 a98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a9b:	85 d2                	test   %edx,%edx
 a9d:	0f 84 9d 00 00 00    	je     b40 <malloc+0xc0>
 aa3:	8b 02                	mov    (%edx),%eax
 aa5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 aa8:	39 cf                	cmp    %ecx,%edi
 aaa:	76 6c                	jbe    b18 <malloc+0x98>
 aac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ab2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ab7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 aba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ac1:	eb 0e                	jmp    ad1 <malloc+0x51>
 ac3:	90                   	nop
 ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aca:	8b 48 04             	mov    0x4(%eax),%ecx
 acd:	39 f9                	cmp    %edi,%ecx
 acf:	73 47                	jae    b18 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ad1:	39 05 90 0f 00 00    	cmp    %eax,0xf90
 ad7:	89 c2                	mov    %eax,%edx
 ad9:	75 ed                	jne    ac8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 adb:	83 ec 0c             	sub    $0xc,%esp
 ade:	56                   	push   %esi
 adf:	e8 2a fc ff ff       	call   70e <sbrk>
  if(p == (char*)-1)
 ae4:	83 c4 10             	add    $0x10,%esp
 ae7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aea:	74 1c                	je     b08 <malloc+0x88>
  hp->s.size = nu;
 aec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aef:	83 ec 0c             	sub    $0xc,%esp
 af2:	83 c0 08             	add    $0x8,%eax
 af5:	50                   	push   %eax
 af6:	e8 f5 fe ff ff       	call   9f0 <free>
  return freep;
 afb:	8b 15 90 0f 00 00    	mov    0xf90,%edx
      if((p = morecore(nunits)) == 0)
 b01:	83 c4 10             	add    $0x10,%esp
 b04:	85 d2                	test   %edx,%edx
 b06:	75 c0                	jne    ac8 <malloc+0x48>
        return 0;
  }
}
 b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b0b:	31 c0                	xor    %eax,%eax
}
 b0d:	5b                   	pop    %ebx
 b0e:	5e                   	pop    %esi
 b0f:	5f                   	pop    %edi
 b10:	5d                   	pop    %ebp
 b11:	c3                   	ret    
 b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b18:	39 cf                	cmp    %ecx,%edi
 b1a:	74 54                	je     b70 <malloc+0xf0>
        p->s.size -= nunits;
 b1c:	29 f9                	sub    %edi,%ecx
 b1e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b21:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b24:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b27:	89 15 90 0f 00 00    	mov    %edx,0xf90
}
 b2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b30:	83 c0 08             	add    $0x8,%eax
}
 b33:	5b                   	pop    %ebx
 b34:	5e                   	pop    %esi
 b35:	5f                   	pop    %edi
 b36:	5d                   	pop    %ebp
 b37:	c3                   	ret    
 b38:	90                   	nop
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b40:	c7 05 90 0f 00 00 94 	movl   $0xf94,0xf90
 b47:	0f 00 00 
 b4a:	c7 05 94 0f 00 00 94 	movl   $0xf94,0xf94
 b51:	0f 00 00 
    base.s.size = 0;
 b54:	b8 94 0f 00 00       	mov    $0xf94,%eax
 b59:	c7 05 98 0f 00 00 00 	movl   $0x0,0xf98
 b60:	00 00 00 
 b63:	e9 44 ff ff ff       	jmp    aac <malloc+0x2c>
 b68:	90                   	nop
 b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b70:	8b 08                	mov    (%eax),%ecx
 b72:	89 0a                	mov    %ecx,(%edx)
 b74:	eb b1                	jmp    b27 <malloc+0xa7>
