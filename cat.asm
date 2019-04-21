
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 1a 07 00 00       	call   756 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 e2 06 00 00       	call   73e <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 ad 06 00 00       	call   716 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 2b 0c 00 00       	push   $0xc2b
  71:	6a 01                	push   $0x1
  73:	e8 38 08 00 00       	call   8b0 <printf>
      exit();
  78:	e8 99 06 00 00       	call   716 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 8a 06 00 00       	call   716 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 a0 7d 03 00       	push   $0x37da0
  a9:	6a 01                	push   $0x1
  ab:	e8 86 06 00 00       	call   736 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 26                	jne    dd <cat+0x4d>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 a0 7d 03 00       	push   $0x37da0
  c4:	56                   	push   %esi
  c5:	e8 64 06 00 00       	call   72e <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	83 f8 00             	cmp    $0x0,%eax
  d0:	89 c3                	mov    %eax,%ebx
  d2:	7f cc                	jg     a0 <cat+0x10>
  if(n < 0){
  d4:	75 1b                	jne    f1 <cat+0x61>
}
  d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d9:	5b                   	pop    %ebx
  da:	5e                   	pop    %esi
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
      printf(1, "cat: write error\n");
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	68 08 0c 00 00       	push   $0xc08
  e5:	6a 01                	push   $0x1
  e7:	e8 c4 07 00 00       	call   8b0 <printf>
      exit();
  ec:	e8 25 06 00 00       	call   716 <exit>
    printf(1, "cat: read error\n");
  f1:	50                   	push   %eax
  f2:	50                   	push   %eax
  f3:	68 1a 0c 00 00       	push   $0xc1a
  f8:	6a 01                	push   $0x1
  fa:	e8 b1 07 00 00       	call   8b0 <printf>
    exit();
  ff:	e8 12 06 00 00       	call   716 <exit>
 104:	66 90                	xchg   %ax,%ax
 106:	66 90                	xchg   %ax,%ax
 108:	66 90                	xchg   %ax,%ax
 10a:	66 90                	xchg   %ax,%ax
 10c:	66 90                	xchg   %ax,%ax
 10e:	66 90                	xchg   %ax,%ax

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 c1 01             	add    $0x1,%ecx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 db                	test   %bl,%bl
 12c:	88 5a ff             	mov    %bl,-0x1(%edx)
 12f:	75 ef                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	84 c0                	test   %al,%al
 152:	75 1c                	jne    170 <strcmp+0x30>
 154:	eb 2a                	jmp    180 <strcmp+0x40>
 156:	8d 76 00             	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 160:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 163:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 166:	83 c1 01             	add    $0x1,%ecx
 169:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 16c:	84 c0                	test   %al,%al
 16e:	74 10                	je     180 <strcmp+0x40>
 170:	38 d8                	cmp    %bl,%al
 172:	74 ec                	je     160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 174:	29 d8                	sub    %ebx,%eax
}
 176:	5b                   	pop    %ebx
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 182:	29 d8                	sub    %ebx,%eax
}
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1b0:	31 c0                	xor    %eax,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 1d                	je     20e <strchr+0x2e>
    if(*s == c)
 1f1:	38 d3                	cmp    %dl,%bl
 1f3:	89 d9                	mov    %ebx,%ecx
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
  for(; *s; s++)
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
      return (char*)s;
  return 0;
 20e:	31 c0                	xor    %eax,%eax
}
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	31 f6                	xor    %esi,%esi
 228:	89 f3                	mov    %esi,%ebx
{
 22a:	83 ec 1c             	sub    $0x1c,%esp
 22d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 230:	eb 2f                	jmp    261 <gets+0x41>
 232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 238:	8d 45 e7             	lea    -0x19(%ebp),%eax
 23b:	83 ec 04             	sub    $0x4,%esp
 23e:	6a 01                	push   $0x1
 240:	50                   	push   %eax
 241:	6a 00                	push   $0x0
 243:	e8 e6 04 00 00       	call   72e <read>
    if(cc < 1)
 248:	83 c4 10             	add    $0x10,%esp
 24b:	85 c0                	test   %eax,%eax
 24d:	7e 1c                	jle    26b <gets+0x4b>
      break;
    buf[i++] = c;
 24f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 253:	83 c7 01             	add    $0x1,%edi
 256:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 23                	je     280 <gets+0x60>
 25d:	3c 0d                	cmp    $0xd,%al
 25f:	74 1f                	je     280 <gets+0x60>
  for(i=0; i+1 < max; ){
 261:	83 c3 01             	add    $0x1,%ebx
 264:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 267:	89 fe                	mov    %edi,%esi
 269:	7c cd                	jl     238 <gets+0x18>
 26b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 270:	c6 03 00             	movb   $0x0,(%ebx)
}
 273:	8d 65 f4             	lea    -0xc(%ebp),%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	8b 75 08             	mov    0x8(%ebp),%esi
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 de                	add    %ebx,%esi
 288:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 28a:	c6 03 00             	movb   $0x0,(%ebx)
}
 28d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 290:	5b                   	pop    %ebx
 291:	5e                   	pop    %esi
 292:	5f                   	pop    %edi
 293:	5d                   	pop    %ebp
 294:	c3                   	ret    
 295:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	pushl  0x8(%ebp)
 2ad:	e8 a4 04 00 00       	call   756 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	pushl  0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 a7 04 00 00       	call   76e <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 6d 04 00 00       	call   73e <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 2fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 304:	77 1f                	ja     325 <atoi+0x35>
 306:	8d 76 00             	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 310:	8d 04 80             	lea    (%eax,%eax,4),%eax
 313:	83 c1 01             	add    $0x1,%ecx
 316:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 31a:	0f be 11             	movsbl (%ecx),%edx
 31d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	5b                   	pop    %ebx
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 5d 10             	mov    0x10(%ebp),%ebx
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 db                	test   %ebx,%ebx
 340:	7e 14                	jle    356 <memmove+0x26>
 342:	31 d2                	xor    %edx,%edx
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 348:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 34c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 34f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 352:	39 d3                	cmp    %edx,%ebx
 354:	75 f2                	jne    348 <memmove+0x18>
  return vdst;
}
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 368:	31 db                	xor    %ebx,%ebx
{
 36a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 36d:	80 39 00             	cmpb   $0x0,(%ecx)
 370:	0f b6 02             	movzbl (%edx),%eax
 373:	74 33                	je     3a8 <mystrcmp+0x48>
 375:	8d 76 00             	lea    0x0(%esi),%esi
 378:	83 c1 01             	add    $0x1,%ecx
 37b:	83 c3 01             	add    $0x1,%ebx
 37e:	80 39 00             	cmpb   $0x0,(%ecx)
 381:	75 f5                	jne    378 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 383:	84 c0                	test   %al,%al
 385:	74 51                	je     3d8 <mystrcmp+0x78>
    int a =0,b=0;
 387:	31 f6                	xor    %esi,%esi
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 390:	83 c2 01             	add    $0x1,%edx
 393:	83 c6 01             	add    $0x1,%esi
 396:	80 3a 00             	cmpb   $0x0,(%edx)
 399:	75 f5                	jne    390 <mystrcmp+0x30>

    if(a!=b)return 0;
 39b:	31 c0                	xor    %eax,%eax
 39d:	39 de                	cmp    %ebx,%esi
 39f:	74 0f                	je     3b0 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 3a1:	5b                   	pop    %ebx
 3a2:	5e                   	pop    %esi
 3a3:	5d                   	pop    %ebp
 3a4:	c3                   	ret    
 3a5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 3a8:	84 c0                	test   %al,%al
 3aa:	75 db                	jne    387 <mystrcmp+0x27>
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b0:	01 d3                	add    %edx,%ebx
 3b2:	eb 13                	jmp    3c7 <mystrcmp+0x67>
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 3b8:	83 c2 01             	add    $0x1,%edx
 3bb:	83 c1 01             	add    $0x1,%ecx
 3be:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 3c2:	38 41 ff             	cmp    %al,-0x1(%ecx)
 3c5:	75 11                	jne    3d8 <mystrcmp+0x78>
    while(a--){
 3c7:	39 d3                	cmp    %edx,%ebx
 3c9:	75 ed                	jne    3b8 <mystrcmp+0x58>
}
 3cb:	5b                   	pop    %ebx
    return 1;
 3cc:	b8 01 00 00 00       	mov    $0x1,%eax
}
 3d1:	5e                   	pop    %esi
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d8:	5b                   	pop    %ebx
    if(a!=b)return 0;
 3d9:	31 c0                	xor    %eax,%eax
}
 3db:	5e                   	pop    %esi
 3dc:	5d                   	pop    %ebp
 3dd:	c3                   	ret    
 3de:	66 90                	xchg   %ax,%ax

000003e0 <fmtname>:

char*
fmtname(char *path)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
 3e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 3e8:	83 ec 0c             	sub    $0xc,%esp
 3eb:	53                   	push   %ebx
 3ec:	e8 9f fd ff ff       	call   190 <strlen>
 3f1:	83 c4 10             	add    $0x10,%esp
 3f4:	01 d8                	add    %ebx,%eax
 3f6:	73 0f                	jae    407 <fmtname+0x27>
 3f8:	eb 12                	jmp    40c <fmtname+0x2c>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 400:	83 e8 01             	sub    $0x1,%eax
 403:	39 c3                	cmp    %eax,%ebx
 405:	77 05                	ja     40c <fmtname+0x2c>
 407:	80 38 2f             	cmpb   $0x2f,(%eax)
 40a:	75 f4                	jne    400 <fmtname+0x20>
    ;
  p++;
 40c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 40f:	83 ec 0c             	sub    $0xc,%esp
 412:	53                   	push   %ebx
 413:	e8 78 fd ff ff       	call   190 <strlen>
 418:	83 c4 10             	add    $0x10,%esp
 41b:	83 f8 0d             	cmp    $0xd,%eax
 41e:	77 4a                	ja     46a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 420:	83 ec 0c             	sub    $0xc,%esp
 423:	53                   	push   %ebx
 424:	e8 67 fd ff ff       	call   190 <strlen>
 429:	83 c4 0c             	add    $0xc,%esp
 42c:	50                   	push   %eax
 42d:	53                   	push   %ebx
 42e:	68 40 10 00 00       	push   $0x1040
 433:	e8 f8 fe ff ff       	call   330 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 438:	89 1c 24             	mov    %ebx,(%esp)
 43b:	e8 50 fd ff ff       	call   190 <strlen>
 440:	89 1c 24             	mov    %ebx,(%esp)
 443:	89 c6                	mov    %eax,%esi
  return buf;
 445:	bb 40 10 00 00       	mov    $0x1040,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 44a:	e8 41 fd ff ff       	call   190 <strlen>
 44f:	ba 0e 00 00 00       	mov    $0xe,%edx
 454:	83 c4 0c             	add    $0xc,%esp
 457:	05 40 10 00 00       	add    $0x1040,%eax
 45c:	29 f2                	sub    %esi,%edx
 45e:	52                   	push   %edx
 45f:	6a 20                	push   $0x20
 461:	50                   	push   %eax
 462:	e8 59 fd ff ff       	call   1c0 <memset>
  return buf;
 467:	83 c4 10             	add    $0x10,%esp
}
 46a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 46d:	89 d8                	mov    %ebx,%eax
 46f:	5b                   	pop    %ebx
 470:	5e                   	pop    %esi
 471:	5d                   	pop    %ebp
 472:	c3                   	ret    
 473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <ls>:

void
ls(char *path)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 48c:	e8 6d 03 00 00       	call   7fe <getcid>

  printf(2, "Cid is: %d\n", cid);
 491:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 494:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 496:	50                   	push   %eax
 497:	68 40 0c 00 00       	push   $0xc40
 49c:	6a 02                	push   $0x2
 49e:	e8 0d 04 00 00       	call   8b0 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 4a3:	59                   	pop    %ecx
 4a4:	5b                   	pop    %ebx
 4a5:	6a 00                	push   $0x0
 4a7:	ff 75 08             	pushl  0x8(%ebp)
 4aa:	e8 a7 02 00 00       	call   756 <open>
 4af:	83 c4 10             	add    $0x10,%esp
 4b2:	85 c0                	test   %eax,%eax
 4b4:	78 5a                	js     510 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 4b6:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 4bc:	83 ec 08             	sub    $0x8,%esp
 4bf:	89 c3                	mov    %eax,%ebx
 4c1:	56                   	push   %esi
 4c2:	50                   	push   %eax
 4c3:	e8 a6 02 00 00       	call   76e <fstat>
 4c8:	83 c4 10             	add    $0x10,%esp
 4cb:	85 c0                	test   %eax,%eax
 4cd:	0f 88 cd 00 00 00    	js     5a0 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 4d3:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 4da:	66 83 f8 01          	cmp    $0x1,%ax
 4de:	74 50                	je     530 <ls+0xb0>
 4e0:	66 83 f8 02          	cmp    $0x2,%ax
 4e4:	75 12                	jne    4f8 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 4e6:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 4ec:	8d 42 01             	lea    0x1(%edx),%eax
 4ef:	83 f8 01             	cmp    $0x1,%eax
 4f2:	76 6c                	jbe    560 <ls+0xe0>
 4f4:	39 fa                	cmp    %edi,%edx
 4f6:	74 68                	je     560 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	53                   	push   %ebx
 4fc:	e8 3d 02 00 00       	call   73e <close>
 501:	83 c4 10             	add    $0x10,%esp

}
 504:	8d 65 f4             	lea    -0xc(%ebp),%esp
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	68 4c 0c 00 00       	push   $0xc4c
 51b:	6a 02                	push   $0x2
 51d:	e8 8e 03 00 00       	call   8b0 <printf>
    return;
 522:	83 c4 10             	add    $0x10,%esp
}
 525:	8d 65 f4             	lea    -0xc(%ebp),%esp
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5f                   	pop    %edi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret    
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	ff 75 08             	pushl  0x8(%ebp)
 536:	e8 55 fc ff ff       	call   190 <strlen>
 53b:	83 c0 10             	add    $0x10,%eax
 53e:	83 c4 10             	add    $0x10,%esp
 541:	3d 00 02 00 00       	cmp    $0x200,%eax
 546:	0f 86 7c 00 00 00    	jbe    5c8 <ls+0x148>
      printf(1, "ls: path too long\n");
 54c:	83 ec 08             	sub    $0x8,%esp
 54f:	68 84 0c 00 00       	push   $0xc84
 554:	6a 01                	push   $0x1
 556:	e8 55 03 00 00       	call   8b0 <printf>
      break;
 55b:	83 c4 10             	add    $0x10,%esp
 55e:	eb 98                	jmp    4f8 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 56c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 572:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 578:	e8 63 fe ff ff       	call   3e0 <fmtname>
 57d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 583:	83 c4 0c             	add    $0xc,%esp
 586:	52                   	push   %edx
 587:	57                   	push   %edi
 588:	56                   	push   %esi
 589:	6a 02                	push   $0x2
 58b:	50                   	push   %eax
 58c:	68 74 0c 00 00       	push   $0xc74
 591:	6a 01                	push   $0x1
 593:	e8 18 03 00 00       	call   8b0 <printf>
    break;
 598:	83 c4 20             	add    $0x20,%esp
 59b:	e9 58 ff ff ff       	jmp    4f8 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	ff 75 08             	pushl  0x8(%ebp)
 5a6:	68 60 0c 00 00       	push   $0xc60
 5ab:	6a 02                	push   $0x2
 5ad:	e8 fe 02 00 00       	call   8b0 <printf>
    close(fd);
 5b2:	89 1c 24             	mov    %ebx,(%esp)
 5b5:	e8 84 01 00 00       	call   73e <close>
    return;
 5ba:	83 c4 10             	add    $0x10,%esp
}
 5bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c0:	5b                   	pop    %ebx
 5c1:	5e                   	pop    %esi
 5c2:	5f                   	pop    %edi
 5c3:	5d                   	pop    %ebp
 5c4:	c3                   	ret    
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 5c8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5ce:	83 ec 08             	sub    $0x8,%esp
 5d1:	ff 75 08             	pushl  0x8(%ebp)
 5d4:	50                   	push   %eax
 5d5:	e8 36 fb ff ff       	call   110 <strcpy>
    p = buf+strlen(buf);
 5da:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5e0:	89 04 24             	mov    %eax,(%esp)
 5e3:	e8 a8 fb ff ff       	call   190 <strlen>
 5e8:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 5ee:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 5f1:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 5f3:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 5f6:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 5fc:	c6 00 2f             	movb   $0x2f,(%eax)
 5ff:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 605:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 608:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 60e:	83 ec 04             	sub    $0x4,%esp
 611:	6a 10                	push   $0x10
 613:	50                   	push   %eax
 614:	53                   	push   %ebx
 615:	e8 14 01 00 00       	call   72e <read>
 61a:	83 c4 10             	add    $0x10,%esp
 61d:	83 f8 10             	cmp    $0x10,%eax
 620:	0f 85 d2 fe ff ff    	jne    4f8 <ls+0x78>
      if(de.inum == 0)
 626:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 62d:	00 
 62e:	74 d8                	je     608 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 630:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 636:	83 ec 04             	sub    $0x4,%esp
 639:	6a 0e                	push   $0xe
 63b:	50                   	push   %eax
 63c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 642:	e8 e9 fc ff ff       	call   330 <memmove>
      p[DIRSIZ] = 0;
 647:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 64d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 651:	58                   	pop    %eax
 652:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 658:	5a                   	pop    %edx
 659:	56                   	push   %esi
 65a:	50                   	push   %eax
 65b:	e8 40 fc ff ff       	call   2a0 <stat>
 660:	83 c4 10             	add    $0x10,%esp
 663:	85 c0                	test   %eax,%eax
 665:	0f 88 85 00 00 00    	js     6f0 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 66b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 671:	8d 42 01             	lea    0x1(%edx),%eax
 674:	83 f8 01             	cmp    $0x1,%eax
 677:	76 04                	jbe    67d <ls+0x1fd>
 679:	39 fa                	cmp    %edi,%edx
 67b:	75 8b                	jne    608 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 67d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 683:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 689:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 68f:	83 ec 0c             	sub    $0xc,%esp
 692:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 698:	52                   	push   %edx
 699:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 69f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 6a6:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 6ac:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 6b2:	e8 29 fd ff ff       	call   3e0 <fmtname>
 6b7:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 6bd:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 6c3:	83 c4 0c             	add    $0xc,%esp
 6c6:	52                   	push   %edx
 6c7:	51                   	push   %ecx
 6c8:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 6ce:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 6d4:	50                   	push   %eax
 6d5:	68 74 0c 00 00       	push   $0xc74
 6da:	6a 01                	push   $0x1
 6dc:	e8 cf 01 00 00       	call   8b0 <printf>
 6e1:	83 c4 20             	add    $0x20,%esp
 6e4:	e9 1f ff ff ff       	jmp    608 <ls+0x188>
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 6f0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 6f6:	83 ec 04             	sub    $0x4,%esp
 6f9:	50                   	push   %eax
 6fa:	68 60 0c 00 00       	push   $0xc60
 6ff:	6a 01                	push   $0x1
 701:	e8 aa 01 00 00       	call   8b0 <printf>
        continue;
 706:	83 c4 10             	add    $0x10,%esp
 709:	e9 fa fe ff ff       	jmp    608 <ls+0x188>

0000070e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 70e:	b8 01 00 00 00       	mov    $0x1,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <exit>:
SYSCALL(exit)
 716:	b8 02 00 00 00       	mov    $0x2,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <wait>:
SYSCALL(wait)
 71e:	b8 03 00 00 00       	mov    $0x3,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <pipe>:
SYSCALL(pipe)
 726:	b8 04 00 00 00       	mov    $0x4,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <read>:
SYSCALL(read)
 72e:	b8 05 00 00 00       	mov    $0x5,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <write>:
SYSCALL(write)
 736:	b8 10 00 00 00       	mov    $0x10,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <close>:
SYSCALL(close)
 73e:	b8 15 00 00 00       	mov    $0x15,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <kill>:
SYSCALL(kill)
 746:	b8 06 00 00 00       	mov    $0x6,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <exec>:
SYSCALL(exec)
 74e:	b8 07 00 00 00       	mov    $0x7,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <open>:
SYSCALL(open)
 756:	b8 0f 00 00 00       	mov    $0xf,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <mknod>:
SYSCALL(mknod)
 75e:	b8 11 00 00 00       	mov    $0x11,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    

00000766 <unlink>:
SYSCALL(unlink)
 766:	b8 12 00 00 00       	mov    $0x12,%eax
 76b:	cd 40                	int    $0x40
 76d:	c3                   	ret    

0000076e <fstat>:
SYSCALL(fstat)
 76e:	b8 08 00 00 00       	mov    $0x8,%eax
 773:	cd 40                	int    $0x40
 775:	c3                   	ret    

00000776 <link>:
SYSCALL(link)
 776:	b8 13 00 00 00       	mov    $0x13,%eax
 77b:	cd 40                	int    $0x40
 77d:	c3                   	ret    

0000077e <mkdir>:
SYSCALL(mkdir)
 77e:	b8 14 00 00 00       	mov    $0x14,%eax
 783:	cd 40                	int    $0x40
 785:	c3                   	ret    

00000786 <chdir>:
SYSCALL(chdir)
 786:	b8 09 00 00 00       	mov    $0x9,%eax
 78b:	cd 40                	int    $0x40
 78d:	c3                   	ret    

0000078e <dup>:
SYSCALL(dup)
 78e:	b8 0a 00 00 00       	mov    $0xa,%eax
 793:	cd 40                	int    $0x40
 795:	c3                   	ret    

00000796 <getpid>:
SYSCALL(getpid)
 796:	b8 0b 00 00 00       	mov    $0xb,%eax
 79b:	cd 40                	int    $0x40
 79d:	c3                   	ret    

0000079e <sbrk>:
SYSCALL(sbrk)
 79e:	b8 0c 00 00 00       	mov    $0xc,%eax
 7a3:	cd 40                	int    $0x40
 7a5:	c3                   	ret    

000007a6 <sleep>:
SYSCALL(sleep)
 7a6:	b8 0d 00 00 00       	mov    $0xd,%eax
 7ab:	cd 40                	int    $0x40
 7ad:	c3                   	ret    

000007ae <uptime>:
SYSCALL(uptime)
 7ae:	b8 0e 00 00 00       	mov    $0xe,%eax
 7b3:	cd 40                	int    $0x40
 7b5:	c3                   	ret    

000007b6 <halt>:
SYSCALL(halt)
 7b6:	b8 16 00 00 00       	mov    $0x16,%eax
 7bb:	cd 40                	int    $0x40
 7bd:	c3                   	ret    

000007be <toggle>:
SYSCALL(toggle)
 7be:	b8 17 00 00 00       	mov    $0x17,%eax
 7c3:	cd 40                	int    $0x40
 7c5:	c3                   	ret    

000007c6 <ps>:
SYSCALL(ps)
 7c6:	b8 18 00 00 00       	mov    $0x18,%eax
 7cb:	cd 40                	int    $0x40
 7cd:	c3                   	ret    

000007ce <create_container>:
SYSCALL(create_container)
 7ce:	b8 1c 00 00 00       	mov    $0x1c,%eax
 7d3:	cd 40                	int    $0x40
 7d5:	c3                   	ret    

000007d6 <destroy_container>:
SYSCALL(destroy_container)
 7d6:	b8 19 00 00 00       	mov    $0x19,%eax
 7db:	cd 40                	int    $0x40
 7dd:	c3                   	ret    

000007de <join_container>:
SYSCALL(join_container)
 7de:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7e3:	cd 40                	int    $0x40
 7e5:	c3                   	ret    

000007e6 <leave_container>:
SYSCALL(leave_container)
 7e6:	b8 1b 00 00 00       	mov    $0x1b,%eax
 7eb:	cd 40                	int    $0x40
 7ed:	c3                   	ret    

000007ee <send>:
SYSCALL(send)
 7ee:	b8 1d 00 00 00       	mov    $0x1d,%eax
 7f3:	cd 40                	int    $0x40
 7f5:	c3                   	ret    

000007f6 <recv>:
SYSCALL(recv)
 7f6:	b8 1e 00 00 00       	mov    $0x1e,%eax
 7fb:	cd 40                	int    $0x40
 7fd:	c3                   	ret    

000007fe <getcid>:
SYSCALL(getcid)
 7fe:	b8 1f 00 00 00       	mov    $0x1f,%eax
 803:	cd 40                	int    $0x40
 805:	c3                   	ret    
 806:	66 90                	xchg   %ax,%ax
 808:	66 90                	xchg   %ax,%ax
 80a:	66 90                	xchg   %ax,%ax
 80c:	66 90                	xchg   %ax,%ax
 80e:	66 90                	xchg   %ax,%ax

00000810 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 819:	85 d2                	test   %edx,%edx
{
 81b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 81e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 820:	79 76                	jns    898 <printint+0x88>
 822:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 826:	74 70                	je     898 <printint+0x88>
    x = -xx;
 828:	f7 d8                	neg    %eax
    neg = 1;
 82a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 831:	31 f6                	xor    %esi,%esi
 833:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 836:	eb 0a                	jmp    842 <printint+0x32>
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 840:	89 fe                	mov    %edi,%esi
 842:	31 d2                	xor    %edx,%edx
 844:	8d 7e 01             	lea    0x1(%esi),%edi
 847:	f7 f1                	div    %ecx
 849:	0f b6 92 a0 0c 00 00 	movzbl 0xca0(%edx),%edx
  }while((x /= base) != 0);
 850:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 852:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 855:	75 e9                	jne    840 <printint+0x30>
  if(neg)
 857:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 85a:	85 c0                	test   %eax,%eax
 85c:	74 08                	je     866 <printint+0x56>
    buf[i++] = '-';
 85e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 863:	8d 7e 02             	lea    0x2(%esi),%edi
 866:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 86a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
 870:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 873:	83 ec 04             	sub    $0x4,%esp
 876:	83 ee 01             	sub    $0x1,%esi
 879:	6a 01                	push   $0x1
 87b:	53                   	push   %ebx
 87c:	57                   	push   %edi
 87d:	88 45 d7             	mov    %al,-0x29(%ebp)
 880:	e8 b1 fe ff ff       	call   736 <write>

  while(--i >= 0)
 885:	83 c4 10             	add    $0x10,%esp
 888:	39 de                	cmp    %ebx,%esi
 88a:	75 e4                	jne    870 <printint+0x60>
    putc(fd, buf[i]);
}
 88c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88f:	5b                   	pop    %ebx
 890:	5e                   	pop    %esi
 891:	5f                   	pop    %edi
 892:	5d                   	pop    %ebp
 893:	c3                   	ret    
 894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 898:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 89f:	eb 90                	jmp    831 <printint+0x21>
 8a1:	eb 0d                	jmp    8b0 <printf>
 8a3:	90                   	nop
 8a4:	90                   	nop
 8a5:	90                   	nop
 8a6:	90                   	nop
 8a7:	90                   	nop
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	90                   	nop
 8ab:	90                   	nop
 8ac:	90                   	nop
 8ad:	90                   	nop
 8ae:	90                   	nop
 8af:	90                   	nop

000008b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8bc:	0f b6 1e             	movzbl (%esi),%ebx
 8bf:	84 db                	test   %bl,%bl
 8c1:	0f 84 b3 00 00 00    	je     97a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 8c7:	8d 45 10             	lea    0x10(%ebp),%eax
 8ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
 8cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 8cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8d2:	eb 2f                	jmp    903 <printf+0x53>
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8d8:	83 f8 25             	cmp    $0x25,%eax
 8db:	0f 84 a7 00 00 00    	je     988 <printf+0xd8>
  write(fd, &c, 1);
 8e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8e4:	83 ec 04             	sub    $0x4,%esp
 8e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 8ea:	6a 01                	push   $0x1
 8ec:	50                   	push   %eax
 8ed:	ff 75 08             	pushl  0x8(%ebp)
 8f0:	e8 41 fe ff ff       	call   736 <write>
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 8fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 8ff:	84 db                	test   %bl,%bl
 901:	74 77                	je     97a <printf+0xca>
    if(state == 0){
 903:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 905:	0f be cb             	movsbl %bl,%ecx
 908:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 90b:	74 cb                	je     8d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 90d:	83 ff 25             	cmp    $0x25,%edi
 910:	75 e6                	jne    8f8 <printf+0x48>
      if(c == 'd'){
 912:	83 f8 64             	cmp    $0x64,%eax
 915:	0f 84 05 01 00 00    	je     a20 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 91b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 921:	83 f9 70             	cmp    $0x70,%ecx
 924:	74 72                	je     998 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 926:	83 f8 73             	cmp    $0x73,%eax
 929:	0f 84 99 00 00 00    	je     9c8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 92f:	83 f8 63             	cmp    $0x63,%eax
 932:	0f 84 08 01 00 00    	je     a40 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 938:	83 f8 25             	cmp    $0x25,%eax
 93b:	0f 84 ef 00 00 00    	je     a30 <printf+0x180>
  write(fd, &c, 1);
 941:	8d 45 e7             	lea    -0x19(%ebp),%eax
 944:	83 ec 04             	sub    $0x4,%esp
 947:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 94b:	6a 01                	push   $0x1
 94d:	50                   	push   %eax
 94e:	ff 75 08             	pushl  0x8(%ebp)
 951:	e8 e0 fd ff ff       	call   736 <write>
 956:	83 c4 0c             	add    $0xc,%esp
 959:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 95c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 95f:	6a 01                	push   $0x1
 961:	50                   	push   %eax
 962:	ff 75 08             	pushl  0x8(%ebp)
 965:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 968:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 96a:	e8 c7 fd ff ff       	call   736 <write>
  for(i = 0; fmt[i]; i++){
 96f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 973:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 976:	84 db                	test   %bl,%bl
 978:	75 89                	jne    903 <printf+0x53>
    }
  }
}
 97a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 97d:	5b                   	pop    %ebx
 97e:	5e                   	pop    %esi
 97f:	5f                   	pop    %edi
 980:	5d                   	pop    %ebp
 981:	c3                   	ret    
 982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 988:	bf 25 00 00 00       	mov    $0x25,%edi
 98d:	e9 66 ff ff ff       	jmp    8f8 <printf+0x48>
 992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 998:	83 ec 0c             	sub    $0xc,%esp
 99b:	b9 10 00 00 00       	mov    $0x10,%ecx
 9a0:	6a 00                	push   $0x0
 9a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9a5:	8b 45 08             	mov    0x8(%ebp),%eax
 9a8:	8b 17                	mov    (%edi),%edx
 9aa:	e8 61 fe ff ff       	call   810 <printint>
        ap++;
 9af:	89 f8                	mov    %edi,%eax
 9b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9b4:	31 ff                	xor    %edi,%edi
        ap++;
 9b6:	83 c0 04             	add    $0x4,%eax
 9b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9bc:	e9 37 ff ff ff       	jmp    8f8 <printf+0x48>
 9c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9cb:	8b 08                	mov    (%eax),%ecx
        ap++;
 9cd:	83 c0 04             	add    $0x4,%eax
 9d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 9d3:	85 c9                	test   %ecx,%ecx
 9d5:	0f 84 8e 00 00 00    	je     a69 <printf+0x1b9>
        while(*s != 0){
 9db:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 9de:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 9e0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 9e2:	84 c0                	test   %al,%al
 9e4:	0f 84 0e ff ff ff    	je     8f8 <printf+0x48>
 9ea:	89 75 d0             	mov    %esi,-0x30(%ebp)
 9ed:	89 de                	mov    %ebx,%esi
 9ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9f2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 9f5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9f8:	83 ec 04             	sub    $0x4,%esp
          s++;
 9fb:	83 c6 01             	add    $0x1,%esi
 9fe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a01:	6a 01                	push   $0x1
 a03:	57                   	push   %edi
 a04:	53                   	push   %ebx
 a05:	e8 2c fd ff ff       	call   736 <write>
        while(*s != 0){
 a0a:	0f b6 06             	movzbl (%esi),%eax
 a0d:	83 c4 10             	add    $0x10,%esp
 a10:	84 c0                	test   %al,%al
 a12:	75 e4                	jne    9f8 <printf+0x148>
 a14:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a17:	31 ff                	xor    %edi,%edi
 a19:	e9 da fe ff ff       	jmp    8f8 <printf+0x48>
 a1e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a20:	83 ec 0c             	sub    $0xc,%esp
 a23:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a28:	6a 01                	push   $0x1
 a2a:	e9 73 ff ff ff       	jmp    9a2 <printf+0xf2>
 a2f:	90                   	nop
  write(fd, &c, 1);
 a30:	83 ec 04             	sub    $0x4,%esp
 a33:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a36:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a39:	6a 01                	push   $0x1
 a3b:	e9 21 ff ff ff       	jmp    961 <printf+0xb1>
        putc(fd, *ap);
 a40:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a46:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a48:	6a 01                	push   $0x1
        ap++;
 a4a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a4d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a50:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a53:	50                   	push   %eax
 a54:	ff 75 08             	pushl  0x8(%ebp)
 a57:	e8 da fc ff ff       	call   736 <write>
        ap++;
 a5c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a5f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a62:	31 ff                	xor    %edi,%edi
 a64:	e9 8f fe ff ff       	jmp    8f8 <printf+0x48>
          s = "(null)";
 a69:	bb 97 0c 00 00       	mov    $0xc97,%ebx
        while(*s != 0){
 a6e:	b8 28 00 00 00       	mov    $0x28,%eax
 a73:	e9 72 ff ff ff       	jmp    9ea <printf+0x13a>
 a78:	66 90                	xchg   %ax,%ax
 a7a:	66 90                	xchg   %ax,%ax
 a7c:	66 90                	xchg   %ax,%ax
 a7e:	66 90                	xchg   %ax,%ax

00000a80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a81:	a1 50 10 00 00       	mov    0x1050,%eax
{
 a86:	89 e5                	mov    %esp,%ebp
 a88:	57                   	push   %edi
 a89:	56                   	push   %esi
 a8a:	53                   	push   %ebx
 a8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	39 c8                	cmp    %ecx,%eax
 a9a:	8b 10                	mov    (%eax),%edx
 a9c:	73 32                	jae    ad0 <free+0x50>
 a9e:	39 d1                	cmp    %edx,%ecx
 aa0:	72 04                	jb     aa6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	39 d0                	cmp    %edx,%eax
 aa4:	72 32                	jb     ad8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 aa6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aa9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aac:	39 fa                	cmp    %edi,%edx
 aae:	74 30                	je     ae0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ab0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ab3:	8b 50 04             	mov    0x4(%eax),%edx
 ab6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ab9:	39 f1                	cmp    %esi,%ecx
 abb:	74 3a                	je     af7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 abd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 abf:	a3 50 10 00 00       	mov    %eax,0x1050
}
 ac4:	5b                   	pop    %ebx
 ac5:	5e                   	pop    %esi
 ac6:	5f                   	pop    %edi
 ac7:	5d                   	pop    %ebp
 ac8:	c3                   	ret    
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	39 d0                	cmp    %edx,%eax
 ad2:	72 04                	jb     ad8 <free+0x58>
 ad4:	39 d1                	cmp    %edx,%ecx
 ad6:	72 ce                	jb     aa6 <free+0x26>
{
 ad8:	89 d0                	mov    %edx,%eax
 ada:	eb bc                	jmp    a98 <free+0x18>
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ae0:	03 72 04             	add    0x4(%edx),%esi
 ae3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ae6:	8b 10                	mov    (%eax),%edx
 ae8:	8b 12                	mov    (%edx),%edx
 aea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 aed:	8b 50 04             	mov    0x4(%eax),%edx
 af0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 af3:	39 f1                	cmp    %esi,%ecx
 af5:	75 c6                	jne    abd <free+0x3d>
    p->s.size += bp->s.size;
 af7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 afa:	a3 50 10 00 00       	mov    %eax,0x1050
    p->s.size += bp->s.size;
 aff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b02:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b05:	89 10                	mov    %edx,(%eax)
}
 b07:	5b                   	pop    %ebx
 b08:	5e                   	pop    %esi
 b09:	5f                   	pop    %edi
 b0a:	5d                   	pop    %ebp
 b0b:	c3                   	ret    
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	57                   	push   %edi
 b14:	56                   	push   %esi
 b15:	53                   	push   %ebx
 b16:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b1c:	8b 15 50 10 00 00    	mov    0x1050,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b22:	8d 78 07             	lea    0x7(%eax),%edi
 b25:	c1 ef 03             	shr    $0x3,%edi
 b28:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b2b:	85 d2                	test   %edx,%edx
 b2d:	0f 84 9d 00 00 00    	je     bd0 <malloc+0xc0>
 b33:	8b 02                	mov    (%edx),%eax
 b35:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b38:	39 cf                	cmp    %ecx,%edi
 b3a:	76 6c                	jbe    ba8 <malloc+0x98>
 b3c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b42:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b47:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b4a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b51:	eb 0e                	jmp    b61 <malloc+0x51>
 b53:	90                   	nop
 b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b5a:	8b 48 04             	mov    0x4(%eax),%ecx
 b5d:	39 f9                	cmp    %edi,%ecx
 b5f:	73 47                	jae    ba8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b61:	39 05 50 10 00 00    	cmp    %eax,0x1050
 b67:	89 c2                	mov    %eax,%edx
 b69:	75 ed                	jne    b58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b6b:	83 ec 0c             	sub    $0xc,%esp
 b6e:	56                   	push   %esi
 b6f:	e8 2a fc ff ff       	call   79e <sbrk>
  if(p == (char*)-1)
 b74:	83 c4 10             	add    $0x10,%esp
 b77:	83 f8 ff             	cmp    $0xffffffff,%eax
 b7a:	74 1c                	je     b98 <malloc+0x88>
  hp->s.size = nu;
 b7c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b7f:	83 ec 0c             	sub    $0xc,%esp
 b82:	83 c0 08             	add    $0x8,%eax
 b85:	50                   	push   %eax
 b86:	e8 f5 fe ff ff       	call   a80 <free>
  return freep;
 b8b:	8b 15 50 10 00 00    	mov    0x1050,%edx
      if((p = morecore(nunits)) == 0)
 b91:	83 c4 10             	add    $0x10,%esp
 b94:	85 d2                	test   %edx,%edx
 b96:	75 c0                	jne    b58 <malloc+0x48>
        return 0;
  }
}
 b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b9b:	31 c0                	xor    %eax,%eax
}
 b9d:	5b                   	pop    %ebx
 b9e:	5e                   	pop    %esi
 b9f:	5f                   	pop    %edi
 ba0:	5d                   	pop    %ebp
 ba1:	c3                   	ret    
 ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ba8:	39 cf                	cmp    %ecx,%edi
 baa:	74 54                	je     c00 <malloc+0xf0>
        p->s.size -= nunits;
 bac:	29 f9                	sub    %edi,%ecx
 bae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bb1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bb4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bb7:	89 15 50 10 00 00    	mov    %edx,0x1050
}
 bbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bc0:	83 c0 08             	add    $0x8,%eax
}
 bc3:	5b                   	pop    %ebx
 bc4:	5e                   	pop    %esi
 bc5:	5f                   	pop    %edi
 bc6:	5d                   	pop    %ebp
 bc7:	c3                   	ret    
 bc8:	90                   	nop
 bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 bd0:	c7 05 50 10 00 00 54 	movl   $0x1054,0x1050
 bd7:	10 00 00 
 bda:	c7 05 54 10 00 00 54 	movl   $0x1054,0x1054
 be1:	10 00 00 
    base.s.size = 0;
 be4:	b8 54 10 00 00       	mov    $0x1054,%eax
 be9:	c7 05 58 10 00 00 00 	movl   $0x0,0x1058
 bf0:	00 00 00 
 bf3:	e9 44 ff ff ff       	jmp    b3c <malloc+0x2c>
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c00:	8b 08                	mov    (%eax),%ecx
 c02:	89 0a                	mov    %ecx,(%edx)
 c04:	eb b1                	jmp    bb7 <malloc+0xa7>
