
_grep:     file format elf32-i386


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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 ff 01             	cmp    $0x1,%edi
  1c:	7e 7c                	jle    9a <main+0x9a>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1e:	8b 43 04             	mov    0x4(%ebx),%eax
  21:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  24:	83 ff 02             	cmp    $0x2,%edi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  27:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  2f:	74 46                	je     77 <main+0x77>
  31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 32 09 00 00       	call   976 <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	78 3b                	js     86 <main+0x86>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 2; i < argc; i++){
  51:	83 c6 01             	add    $0x1,%esi
    grep(pattern, fd);
  54:	50                   	push   %eax
  55:	ff 75 e0             	pushl  -0x20(%ebp)
  58:	83 c3 04             	add    $0x4,%ebx
  5b:	e8 d0 01 00 00       	call   230 <grep>
    close(fd);
  60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  63:	89 04 24             	mov    %eax,(%esp)
  66:	e8 f3 08 00 00       	call   95e <close>
  for(i = 2; i < argc; i++){
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	39 f7                	cmp    %esi,%edi
  70:	7f c6                	jg     38 <main+0x38>
  }
  exit();
  72:	e8 bf 08 00 00       	call   936 <exit>
    grep(pattern, 0);
  77:	52                   	push   %edx
  78:	52                   	push   %edx
  79:	6a 00                	push   $0x0
  7b:	50                   	push   %eax
  7c:	e8 af 01 00 00       	call   230 <grep>
    exit();
  81:	e8 b0 08 00 00       	call   936 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  86:	50                   	push   %eax
  87:	ff 33                	pushl  (%ebx)
  89:	68 48 0e 00 00       	push   $0xe48
  8e:	6a 01                	push   $0x1
  90:	e8 3b 0a 00 00       	call   ad0 <printf>
      exit();
  95:	e8 9c 08 00 00       	call   936 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  9a:	51                   	push   %ecx
  9b:	51                   	push   %ecx
  9c:	68 28 0e 00 00       	push   $0xe28
  a1:	6a 02                	push   $0x2
  a3:	e8 28 0a 00 00       	call   ad0 <printf>
    exit();
  a8:	e8 89 08 00 00       	call   936 <exit>
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	57                   	push   %edi
  cc:	56                   	push   %esi
  cd:	e8 3e 00 00 00       	call   110 <matchhere>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	75 1f                	jne    f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d9:	0f be 17             	movsbl (%edi),%edx
  dc:	84 d2                	test   %dl,%dl
  de:	74 0c                	je     ec <matchstar+0x3c>
  e0:	83 c7 01             	add    $0x1,%edi
  e3:	39 da                	cmp    %ebx,%edx
  e5:	74 e1                	je     c8 <matchstar+0x18>
  e7:	83 fb 2e             	cmp    $0x2e,%ebx
  ea:	74 dc                	je     c8 <matchstar+0x18>
  return 0;
}
  ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5f                   	pop    %edi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
  fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <matchhere>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 0c             	sub    $0xc,%esp
  if(re[0] == '\0')
 119:	8b 45 08             	mov    0x8(%ebp),%eax
{
 11c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 11f:	0f b6 08             	movzbl (%eax),%ecx
 122:	84 c9                	test   %cl,%cl
 124:	74 67                	je     18d <matchhere+0x7d>
  if(re[1] == '*')
 126:	0f be 40 01          	movsbl 0x1(%eax),%eax
 12a:	3c 2a                	cmp    $0x2a,%al
 12c:	74 6c                	je     19a <matchhere+0x8a>
  if(re[0] == '$' && re[1] == '\0')
 12e:	80 f9 24             	cmp    $0x24,%cl
 131:	0f b6 1f             	movzbl (%edi),%ebx
 134:	75 08                	jne    13e <matchhere+0x2e>
 136:	84 c0                	test   %al,%al
 138:	0f 84 81 00 00 00    	je     1bf <matchhere+0xaf>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 13e:	84 db                	test   %bl,%bl
 140:	74 09                	je     14b <matchhere+0x3b>
 142:	38 d9                	cmp    %bl,%cl
 144:	74 3c                	je     182 <matchhere+0x72>
 146:	80 f9 2e             	cmp    $0x2e,%cl
 149:	74 37                	je     182 <matchhere+0x72>
}
 14b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi
  if(re[1] == '*')
 158:	8b 75 08             	mov    0x8(%ebp),%esi
 15b:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
 15f:	80 f9 2a             	cmp    $0x2a,%cl
 162:	74 3b                	je     19f <matchhere+0x8f>
  if(re[0] == '$' && re[1] == '\0')
 164:	3c 24                	cmp    $0x24,%al
 166:	75 04                	jne    16c <matchhere+0x5c>
 168:	84 c9                	test   %cl,%cl
 16a:	74 4f                	je     1bb <matchhere+0xab>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 16c:	0f b6 33             	movzbl (%ebx),%esi
 16f:	89 f2                	mov    %esi,%edx
 171:	84 d2                	test   %dl,%dl
 173:	74 d6                	je     14b <matchhere+0x3b>
 175:	3c 2e                	cmp    $0x2e,%al
 177:	89 df                	mov    %ebx,%edi
 179:	74 04                	je     17f <matchhere+0x6f>
 17b:	38 c2                	cmp    %al,%dl
 17d:	75 cc                	jne    14b <matchhere+0x3b>
 17f:	0f be c1             	movsbl %cl,%eax
    return matchhere(re+1, text+1);
 182:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  if(re[0] == '\0')
 186:	84 c0                	test   %al,%al
    return matchhere(re+1, text+1);
 188:	8d 5f 01             	lea    0x1(%edi),%ebx
  if(re[0] == '\0')
 18b:	75 cb                	jne    158 <matchhere+0x48>
    return 1;
 18d:	b8 01 00 00 00       	mov    $0x1,%eax
}
 192:	8d 65 f4             	lea    -0xc(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
  if(re[1] == '*')
 19a:	89 fb                	mov    %edi,%ebx
 19c:	0f be c1             	movsbl %cl,%eax
    return matchstar(re[0], re+2, text);
 19f:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a2:	83 ec 04             	sub    $0x4,%esp
 1a5:	53                   	push   %ebx
 1a6:	8d 57 02             	lea    0x2(%edi),%edx
 1a9:	52                   	push   %edx
 1aa:	50                   	push   %eax
 1ab:	e8 00 ff ff ff       	call   b0 <matchstar>
 1b0:	83 c4 10             	add    $0x10,%esp
}
 1b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b6:	5b                   	pop    %ebx
 1b7:	5e                   	pop    %esi
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	0f b6 5f 01          	movzbl 0x1(%edi),%ebx
    return *text == '\0';
 1bf:	31 c0                	xor    %eax,%eax
 1c1:	84 db                	test   %bl,%bl
 1c3:	0f 94 c0             	sete   %al
 1c6:	eb ca                	jmp    192 <matchhere+0x82>
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <match>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 75 08             	mov    0x8(%ebp),%esi
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1db:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1de:	75 11                	jne    1f1 <match+0x21>
 1e0:	eb 2e                	jmp    210 <match+0x40>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1ef:	74 16                	je     207 <match+0x37>
    if(matchhere(re, text))
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	53                   	push   %ebx
 1f5:	56                   	push   %esi
 1f6:	e8 15 ff ff ff       	call   110 <matchhere>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	74 e6                	je     1e8 <match+0x18>
      return 1;
 202:	b8 01 00 00 00       	mov    $0x1,%eax
}
 207:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    
 20e:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 210:	83 c6 01             	add    $0x1,%esi
 213:	89 75 08             	mov    %esi,0x8(%ebp)
}
 216:	8d 65 f8             	lea    -0x8(%ebp),%esp
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 21c:	e9 ef fe ff ff       	jmp    110 <matchhere>
 221:	eb 0d                	jmp    230 <grep>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <grep>:
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
  m = 0;
 236:	31 f6                	xor    %esi,%esi
{
 238:	83 ec 1c             	sub    $0x1c,%esp
 23b:	90                   	nop
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 240:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 245:	83 ec 04             	sub    $0x4,%esp
 248:	29 f0                	sub    %esi,%eax
 24a:	50                   	push   %eax
 24b:	8d 86 80 80 03 00    	lea    0x38080(%esi),%eax
 251:	50                   	push   %eax
 252:	ff 75 0c             	pushl  0xc(%ebp)
 255:	e8 f4 06 00 00       	call   94e <read>
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	85 c0                	test   %eax,%eax
 25f:	0f 8e bb 00 00 00    	jle    320 <grep+0xf0>
    m += n;
 265:	01 c6                	add    %eax,%esi
    p = buf;
 267:	bb 80 80 03 00       	mov    $0x38080,%ebx
    buf[m] = '\0';
 26c:	c6 86 80 80 03 00 00 	movb   $0x0,0x38080(%esi)
 273:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((q = strchr(p, '\n')) != 0){
 280:	83 ec 08             	sub    $0x8,%esp
 283:	6a 0a                	push   $0xa
 285:	53                   	push   %ebx
 286:	e8 75 01 00 00       	call   400 <strchr>
 28b:	83 c4 10             	add    $0x10,%esp
 28e:	85 c0                	test   %eax,%eax
 290:	89 c6                	mov    %eax,%esi
 292:	74 44                	je     2d8 <grep+0xa8>
      if(match(pattern, p)){
 294:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 297:	c6 06 00             	movb   $0x0,(%esi)
 29a:	8d 7e 01             	lea    0x1(%esi),%edi
      if(match(pattern, p)){
 29d:	53                   	push   %ebx
 29e:	ff 75 08             	pushl  0x8(%ebp)
 2a1:	e8 2a ff ff ff       	call   1d0 <match>
 2a6:	83 c4 10             	add    $0x10,%esp
 2a9:	85 c0                	test   %eax,%eax
 2ab:	75 0b                	jne    2b8 <grep+0x88>
      p = q+1;
 2ad:	89 fb                	mov    %edi,%ebx
 2af:	eb cf                	jmp    280 <grep+0x50>
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
 2b8:	89 f8                	mov    %edi,%eax
 2ba:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2bd:	c6 06 0a             	movb   $0xa,(%esi)
        write(1, p, q+1 - p);
 2c0:	29 d8                	sub    %ebx,%eax
 2c2:	50                   	push   %eax
 2c3:	53                   	push   %ebx
      p = q+1;
 2c4:	89 fb                	mov    %edi,%ebx
        write(1, p, q+1 - p);
 2c6:	6a 01                	push   $0x1
 2c8:	e8 89 06 00 00       	call   956 <write>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	eb ae                	jmp    280 <grep+0x50>
 2d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p == buf)
 2d8:	81 fb 80 80 03 00    	cmp    $0x38080,%ebx
 2de:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 2e1:	74 2d                	je     310 <grep+0xe0>
    if(m > 0){
 2e3:	85 f6                	test   %esi,%esi
 2e5:	0f 8e 55 ff ff ff    	jle    240 <grep+0x10>
      m -= p - buf;
 2eb:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2ed:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2f0:	2d 80 80 03 00       	sub    $0x38080,%eax
 2f5:	29 c6                	sub    %eax,%esi
      memmove(buf, p, m);
 2f7:	56                   	push   %esi
 2f8:	53                   	push   %ebx
 2f9:	68 80 80 03 00       	push   $0x38080
 2fe:	e8 4d 02 00 00       	call   550 <memmove>
 303:	83 c4 10             	add    $0x10,%esp
 306:	e9 35 ff ff ff       	jmp    240 <grep+0x10>
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 0;
 310:	31 f6                	xor    %esi,%esi
 312:	e9 29 ff ff ff       	jmp    240 <grep+0x10>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
 320:	8d 65 f4             	lea    -0xc(%ebp),%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	83 c1 01             	add    $0x1,%ecx
 343:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 347:	83 c2 01             	add    $0x1,%edx
 34a:	84 db                	test   %bl,%bl
 34c:	88 5a ff             	mov    %bl,-0x1(%edx)
 34f:	75 ef                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 351:	5b                   	pop    %ebx
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	0f b6 19             	movzbl (%ecx),%ebx
 370:	84 c0                	test   %al,%al
 372:	75 1c                	jne    390 <strcmp+0x30>
 374:	eb 2a                	jmp    3a0 <strcmp+0x40>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 380:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 383:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 386:	83 c1 01             	add    $0x1,%ecx
 389:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 38c:	84 c0                	test   %al,%al
 38e:	74 10                	je     3a0 <strcmp+0x40>
 390:	38 d8                	cmp    %bl,%al
 392:	74 ec                	je     380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 394:	29 d8                	sub    %ebx,%eax
}
 396:	5b                   	pop    %ebx
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strlen>:

uint
strlen(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 39 00             	cmpb   $0x0,(%ecx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 d2                	xor    %edx,%edx
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 3d0:	31 c0                	xor    %eax,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	74 1d                	je     42e <strchr+0x2e>
    if(*s == c)
 411:	38 d3                	cmp    %dl,%bl
 413:	89 d9                	mov    %ebx,%ecx
 415:	75 0d                	jne    424 <strchr+0x24>
 417:	eb 17                	jmp    430 <strchr+0x30>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	38 ca                	cmp    %cl,%dl
 422:	74 0c                	je     430 <strchr+0x30>
  for(; *s; s++)
 424:	83 c0 01             	add    $0x1,%eax
 427:	0f b6 10             	movzbl (%eax),%edx
 42a:	84 d2                	test   %dl,%dl
 42c:	75 f2                	jne    420 <strchr+0x20>
      return (char*)s;
  return 0;
 42e:	31 c0                	xor    %eax,%eax
}
 430:	5b                   	pop    %ebx
 431:	5d                   	pop    %ebp
 432:	c3                   	ret    
 433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 446:	31 f6                	xor    %esi,%esi
 448:	89 f3                	mov    %esi,%ebx
{
 44a:	83 ec 1c             	sub    $0x1c,%esp
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 450:	eb 2f                	jmp    481 <gets+0x41>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 458:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	6a 00                	push   $0x0
 463:	e8 e6 04 00 00       	call   94e <read>
    if(cc < 1)
 468:	83 c4 10             	add    $0x10,%esp
 46b:	85 c0                	test   %eax,%eax
 46d:	7e 1c                	jle    48b <gets+0x4b>
      break;
    buf[i++] = c;
 46f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 473:	83 c7 01             	add    $0x1,%edi
 476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 23                	je     4a0 <gets+0x60>
 47d:	3c 0d                	cmp    $0xd,%al
 47f:	74 1f                	je     4a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 481:	83 c3 01             	add    $0x1,%ebx
 484:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 487:	89 fe                	mov    %edi,%esi
 489:	7c cd                	jl     458 <gets+0x18>
 48b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 490:	c6 03 00             	movb   $0x0,(%ebx)
}
 493:	8d 65 f4             	lea    -0xc(%ebp),%esp
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5f                   	pop    %edi
 499:	5d                   	pop    %ebp
 49a:	c3                   	ret    
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	8b 75 08             	mov    0x8(%ebp),%esi
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 de                	add    %ebx,%esi
 4a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 4ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5f                   	pop    %edi
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 a4 04 00 00       	call   976 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 a7 04 00 00       	call   98e <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 6d 04 00 00       	call   95e <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
  n = 0;
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 572:	39 d3                	cmp    %edx,%ebx
 574:	75 f2                	jne    568 <memmove+0x18>
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    
 57a:	66 90                	xchg   %ax,%ax
 57c:	66 90                	xchg   %ax,%ax
 57e:	66 90                	xchg   %ax,%ax

00000580 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	56                   	push   %esi
 584:	53                   	push   %ebx
 585:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 588:	31 db                	xor    %ebx,%ebx
{
 58a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 58d:	80 39 00             	cmpb   $0x0,(%ecx)
 590:	0f b6 02             	movzbl (%edx),%eax
 593:	74 33                	je     5c8 <mystrcmp+0x48>
 595:	8d 76 00             	lea    0x0(%esi),%esi
 598:	83 c1 01             	add    $0x1,%ecx
 59b:	83 c3 01             	add    $0x1,%ebx
 59e:	80 39 00             	cmpb   $0x0,(%ecx)
 5a1:	75 f5                	jne    598 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 5a3:	84 c0                	test   %al,%al
 5a5:	74 51                	je     5f8 <mystrcmp+0x78>
    int a =0,b=0;
 5a7:	31 f6                	xor    %esi,%esi
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 5b0:	83 c2 01             	add    $0x1,%edx
 5b3:	83 c6 01             	add    $0x1,%esi
 5b6:	80 3a 00             	cmpb   $0x0,(%edx)
 5b9:	75 f5                	jne    5b0 <mystrcmp+0x30>

    if(a!=b)return 0;
 5bb:	31 c0                	xor    %eax,%eax
 5bd:	39 de                	cmp    %ebx,%esi
 5bf:	74 0f                	je     5d0 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 5c1:	5b                   	pop    %ebx
 5c2:	5e                   	pop    %esi
 5c3:	5d                   	pop    %ebp
 5c4:	c3                   	ret    
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 5c8:	84 c0                	test   %al,%al
 5ca:	75 db                	jne    5a7 <mystrcmp+0x27>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d0:	01 d3                	add    %edx,%ebx
 5d2:	eb 13                	jmp    5e7 <mystrcmp+0x67>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 5d8:	83 c2 01             	add    $0x1,%edx
 5db:	83 c1 01             	add    $0x1,%ecx
 5de:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 5e2:	38 41 ff             	cmp    %al,-0x1(%ecx)
 5e5:	75 11                	jne    5f8 <mystrcmp+0x78>
    while(a--){
 5e7:	39 d3                	cmp    %edx,%ebx
 5e9:	75 ed                	jne    5d8 <mystrcmp+0x58>
}
 5eb:	5b                   	pop    %ebx
    return 1;
 5ec:	b8 01 00 00 00       	mov    $0x1,%eax
}
 5f1:	5e                   	pop    %esi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
 5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f8:	5b                   	pop    %ebx
    if(a!=b)return 0;
 5f9:	31 c0                	xor    %eax,%eax
}
 5fb:	5e                   	pop    %esi
 5fc:	5d                   	pop    %ebp
 5fd:	c3                   	ret    
 5fe:	66 90                	xchg   %ax,%ax

00000600 <fmtname>:

char*
fmtname(char *path)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	56                   	push   %esi
 604:	53                   	push   %ebx
 605:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 608:	83 ec 0c             	sub    $0xc,%esp
 60b:	53                   	push   %ebx
 60c:	e8 9f fd ff ff       	call   3b0 <strlen>
 611:	83 c4 10             	add    $0x10,%esp
 614:	01 d8                	add    %ebx,%eax
 616:	73 0f                	jae    627 <fmtname+0x27>
 618:	eb 12                	jmp    62c <fmtname+0x2c>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 620:	83 e8 01             	sub    $0x1,%eax
 623:	39 c3                	cmp    %eax,%ebx
 625:	77 05                	ja     62c <fmtname+0x2c>
 627:	80 38 2f             	cmpb   $0x2f,(%eax)
 62a:	75 f4                	jne    620 <fmtname+0x20>
    ;
  p++;
 62c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 62f:	83 ec 0c             	sub    $0xc,%esp
 632:	53                   	push   %ebx
 633:	e8 78 fd ff ff       	call   3b0 <strlen>
 638:	83 c4 10             	add    $0x10,%esp
 63b:	83 f8 0d             	cmp    $0xd,%eax
 63e:	77 4a                	ja     68a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	53                   	push   %ebx
 644:	e8 67 fd ff ff       	call   3b0 <strlen>
 649:	83 c4 0c             	add    $0xc,%esp
 64c:	50                   	push   %eax
 64d:	53                   	push   %ebx
 64e:	68 20 13 00 00       	push   $0x1320
 653:	e8 f8 fe ff ff       	call   550 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 658:	89 1c 24             	mov    %ebx,(%esp)
 65b:	e8 50 fd ff ff       	call   3b0 <strlen>
 660:	89 1c 24             	mov    %ebx,(%esp)
 663:	89 c6                	mov    %eax,%esi
  return buf;
 665:	bb 20 13 00 00       	mov    $0x1320,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 66a:	e8 41 fd ff ff       	call   3b0 <strlen>
 66f:	ba 0e 00 00 00       	mov    $0xe,%edx
 674:	83 c4 0c             	add    $0xc,%esp
 677:	05 20 13 00 00       	add    $0x1320,%eax
 67c:	29 f2                	sub    %esi,%edx
 67e:	52                   	push   %edx
 67f:	6a 20                	push   $0x20
 681:	50                   	push   %eax
 682:	e8 59 fd ff ff       	call   3e0 <memset>
  return buf;
 687:	83 c4 10             	add    $0x10,%esp
}
 68a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 68d:	89 d8                	mov    %ebx,%eax
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <ls>:

void
ls(char *path)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 6ac:	e8 6d 03 00 00       	call   a1e <getcid>

  printf(2, "Cid is: %d\n", cid);
 6b1:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 6b4:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 6b6:	50                   	push   %eax
 6b7:	68 5e 0e 00 00       	push   $0xe5e
 6bc:	6a 02                	push   $0x2
 6be:	e8 0d 04 00 00       	call   ad0 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 6c3:	59                   	pop    %ecx
 6c4:	5b                   	pop    %ebx
 6c5:	6a 00                	push   $0x0
 6c7:	ff 75 08             	pushl  0x8(%ebp)
 6ca:	e8 a7 02 00 00       	call   976 <open>
 6cf:	83 c4 10             	add    $0x10,%esp
 6d2:	85 c0                	test   %eax,%eax
 6d4:	78 5a                	js     730 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 6d6:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 6dc:	83 ec 08             	sub    $0x8,%esp
 6df:	89 c3                	mov    %eax,%ebx
 6e1:	56                   	push   %esi
 6e2:	50                   	push   %eax
 6e3:	e8 a6 02 00 00       	call   98e <fstat>
 6e8:	83 c4 10             	add    $0x10,%esp
 6eb:	85 c0                	test   %eax,%eax
 6ed:	0f 88 cd 00 00 00    	js     7c0 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 6f3:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 6fa:	66 83 f8 01          	cmp    $0x1,%ax
 6fe:	74 50                	je     750 <ls+0xb0>
 700:	66 83 f8 02          	cmp    $0x2,%ax
 704:	75 12                	jne    718 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 706:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 70c:	8d 42 01             	lea    0x1(%edx),%eax
 70f:	83 f8 01             	cmp    $0x1,%eax
 712:	76 6c                	jbe    780 <ls+0xe0>
 714:	39 fa                	cmp    %edi,%edx
 716:	74 68                	je     780 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 718:	83 ec 0c             	sub    $0xc,%esp
 71b:	53                   	push   %ebx
 71c:	e8 3d 02 00 00       	call   95e <close>
 721:	83 c4 10             	add    $0x10,%esp

}
 724:	8d 65 f4             	lea    -0xc(%ebp),%esp
 727:	5b                   	pop    %ebx
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret    
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	ff 75 08             	pushl  0x8(%ebp)
 736:	68 6a 0e 00 00       	push   $0xe6a
 73b:	6a 02                	push   $0x2
 73d:	e8 8e 03 00 00       	call   ad0 <printf>
    return;
 742:	83 c4 10             	add    $0x10,%esp
}
 745:	8d 65 f4             	lea    -0xc(%ebp),%esp
 748:	5b                   	pop    %ebx
 749:	5e                   	pop    %esi
 74a:	5f                   	pop    %edi
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
 74d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	ff 75 08             	pushl  0x8(%ebp)
 756:	e8 55 fc ff ff       	call   3b0 <strlen>
 75b:	83 c0 10             	add    $0x10,%eax
 75e:	83 c4 10             	add    $0x10,%esp
 761:	3d 00 02 00 00       	cmp    $0x200,%eax
 766:	0f 86 7c 00 00 00    	jbe    7e8 <ls+0x148>
      printf(1, "ls: path too long\n");
 76c:	83 ec 08             	sub    $0x8,%esp
 76f:	68 a2 0e 00 00       	push   $0xea2
 774:	6a 01                	push   $0x1
 776:	e8 55 03 00 00       	call   ad0 <printf>
      break;
 77b:	83 c4 10             	add    $0x10,%esp
 77e:	eb 98                	jmp    718 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	ff 75 08             	pushl  0x8(%ebp)
 786:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 78c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 792:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 798:	e8 63 fe ff ff       	call   600 <fmtname>
 79d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 7a3:	83 c4 0c             	add    $0xc,%esp
 7a6:	52                   	push   %edx
 7a7:	57                   	push   %edi
 7a8:	56                   	push   %esi
 7a9:	6a 02                	push   $0x2
 7ab:	50                   	push   %eax
 7ac:	68 92 0e 00 00       	push   $0xe92
 7b1:	6a 01                	push   $0x1
 7b3:	e8 18 03 00 00       	call   ad0 <printf>
    break;
 7b8:	83 c4 20             	add    $0x20,%esp
 7bb:	e9 58 ff ff ff       	jmp    718 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	ff 75 08             	pushl  0x8(%ebp)
 7c6:	68 7e 0e 00 00       	push   $0xe7e
 7cb:	6a 02                	push   $0x2
 7cd:	e8 fe 02 00 00       	call   ad0 <printf>
    close(fd);
 7d2:	89 1c 24             	mov    %ebx,(%esp)
 7d5:	e8 84 01 00 00       	call   95e <close>
    return;
 7da:	83 c4 10             	add    $0x10,%esp
}
 7dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7e0:	5b                   	pop    %ebx
 7e1:	5e                   	pop    %esi
 7e2:	5f                   	pop    %edi
 7e3:	5d                   	pop    %ebp
 7e4:	c3                   	ret    
 7e5:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 7e8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 7ee:	83 ec 08             	sub    $0x8,%esp
 7f1:	ff 75 08             	pushl  0x8(%ebp)
 7f4:	50                   	push   %eax
 7f5:	e8 36 fb ff ff       	call   330 <strcpy>
    p = buf+strlen(buf);
 7fa:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 800:	89 04 24             	mov    %eax,(%esp)
 803:	e8 a8 fb ff ff       	call   3b0 <strlen>
 808:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 80e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 811:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 813:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 816:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 81c:	c6 00 2f             	movb   $0x2f,(%eax)
 81f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 825:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 828:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 82e:	83 ec 04             	sub    $0x4,%esp
 831:	6a 10                	push   $0x10
 833:	50                   	push   %eax
 834:	53                   	push   %ebx
 835:	e8 14 01 00 00       	call   94e <read>
 83a:	83 c4 10             	add    $0x10,%esp
 83d:	83 f8 10             	cmp    $0x10,%eax
 840:	0f 85 d2 fe ff ff    	jne    718 <ls+0x78>
      if(de.inum == 0)
 846:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 84d:	00 
 84e:	74 d8                	je     828 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 850:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 856:	83 ec 04             	sub    $0x4,%esp
 859:	6a 0e                	push   $0xe
 85b:	50                   	push   %eax
 85c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 862:	e8 e9 fc ff ff       	call   550 <memmove>
      p[DIRSIZ] = 0;
 867:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 86d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 871:	58                   	pop    %eax
 872:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 878:	5a                   	pop    %edx
 879:	56                   	push   %esi
 87a:	50                   	push   %eax
 87b:	e8 40 fc ff ff       	call   4c0 <stat>
 880:	83 c4 10             	add    $0x10,%esp
 883:	85 c0                	test   %eax,%eax
 885:	0f 88 85 00 00 00    	js     910 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 88b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 891:	8d 42 01             	lea    0x1(%edx),%eax
 894:	83 f8 01             	cmp    $0x1,%eax
 897:	76 04                	jbe    89d <ls+0x1fd>
 899:	39 fa                	cmp    %edi,%edx
 89b:	75 8b                	jne    828 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 89d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 8a3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 8a9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 8af:	83 ec 0c             	sub    $0xc,%esp
 8b2:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 8b8:	52                   	push   %edx
 8b9:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 8bf:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 8c6:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 8cc:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 8d2:	e8 29 fd ff ff       	call   600 <fmtname>
 8d7:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 8dd:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 8e3:	83 c4 0c             	add    $0xc,%esp
 8e6:	52                   	push   %edx
 8e7:	51                   	push   %ecx
 8e8:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 8ee:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 8f4:	50                   	push   %eax
 8f5:	68 92 0e 00 00       	push   $0xe92
 8fa:	6a 01                	push   $0x1
 8fc:	e8 cf 01 00 00       	call   ad0 <printf>
 901:	83 c4 20             	add    $0x20,%esp
 904:	e9 1f ff ff ff       	jmp    828 <ls+0x188>
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 910:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 916:	83 ec 04             	sub    $0x4,%esp
 919:	50                   	push   %eax
 91a:	68 7e 0e 00 00       	push   $0xe7e
 91f:	6a 01                	push   $0x1
 921:	e8 aa 01 00 00       	call   ad0 <printf>
        continue;
 926:	83 c4 10             	add    $0x10,%esp
 929:	e9 fa fe ff ff       	jmp    828 <ls+0x188>

0000092e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 92e:	b8 01 00 00 00       	mov    $0x1,%eax
 933:	cd 40                	int    $0x40
 935:	c3                   	ret    

00000936 <exit>:
SYSCALL(exit)
 936:	b8 02 00 00 00       	mov    $0x2,%eax
 93b:	cd 40                	int    $0x40
 93d:	c3                   	ret    

0000093e <wait>:
SYSCALL(wait)
 93e:	b8 03 00 00 00       	mov    $0x3,%eax
 943:	cd 40                	int    $0x40
 945:	c3                   	ret    

00000946 <pipe>:
SYSCALL(pipe)
 946:	b8 04 00 00 00       	mov    $0x4,%eax
 94b:	cd 40                	int    $0x40
 94d:	c3                   	ret    

0000094e <read>:
SYSCALL(read)
 94e:	b8 05 00 00 00       	mov    $0x5,%eax
 953:	cd 40                	int    $0x40
 955:	c3                   	ret    

00000956 <write>:
SYSCALL(write)
 956:	b8 10 00 00 00       	mov    $0x10,%eax
 95b:	cd 40                	int    $0x40
 95d:	c3                   	ret    

0000095e <close>:
SYSCALL(close)
 95e:	b8 15 00 00 00       	mov    $0x15,%eax
 963:	cd 40                	int    $0x40
 965:	c3                   	ret    

00000966 <kill>:
SYSCALL(kill)
 966:	b8 06 00 00 00       	mov    $0x6,%eax
 96b:	cd 40                	int    $0x40
 96d:	c3                   	ret    

0000096e <exec>:
SYSCALL(exec)
 96e:	b8 07 00 00 00       	mov    $0x7,%eax
 973:	cd 40                	int    $0x40
 975:	c3                   	ret    

00000976 <open>:
SYSCALL(open)
 976:	b8 0f 00 00 00       	mov    $0xf,%eax
 97b:	cd 40                	int    $0x40
 97d:	c3                   	ret    

0000097e <mknod>:
SYSCALL(mknod)
 97e:	b8 11 00 00 00       	mov    $0x11,%eax
 983:	cd 40                	int    $0x40
 985:	c3                   	ret    

00000986 <unlink>:
SYSCALL(unlink)
 986:	b8 12 00 00 00       	mov    $0x12,%eax
 98b:	cd 40                	int    $0x40
 98d:	c3                   	ret    

0000098e <fstat>:
SYSCALL(fstat)
 98e:	b8 08 00 00 00       	mov    $0x8,%eax
 993:	cd 40                	int    $0x40
 995:	c3                   	ret    

00000996 <link>:
SYSCALL(link)
 996:	b8 13 00 00 00       	mov    $0x13,%eax
 99b:	cd 40                	int    $0x40
 99d:	c3                   	ret    

0000099e <mkdir>:
SYSCALL(mkdir)
 99e:	b8 14 00 00 00       	mov    $0x14,%eax
 9a3:	cd 40                	int    $0x40
 9a5:	c3                   	ret    

000009a6 <chdir>:
SYSCALL(chdir)
 9a6:	b8 09 00 00 00       	mov    $0x9,%eax
 9ab:	cd 40                	int    $0x40
 9ad:	c3                   	ret    

000009ae <dup>:
SYSCALL(dup)
 9ae:	b8 0a 00 00 00       	mov    $0xa,%eax
 9b3:	cd 40                	int    $0x40
 9b5:	c3                   	ret    

000009b6 <getpid>:
SYSCALL(getpid)
 9b6:	b8 0b 00 00 00       	mov    $0xb,%eax
 9bb:	cd 40                	int    $0x40
 9bd:	c3                   	ret    

000009be <sbrk>:
SYSCALL(sbrk)
 9be:	b8 0c 00 00 00       	mov    $0xc,%eax
 9c3:	cd 40                	int    $0x40
 9c5:	c3                   	ret    

000009c6 <sleep>:
SYSCALL(sleep)
 9c6:	b8 0d 00 00 00       	mov    $0xd,%eax
 9cb:	cd 40                	int    $0x40
 9cd:	c3                   	ret    

000009ce <uptime>:
SYSCALL(uptime)
 9ce:	b8 0e 00 00 00       	mov    $0xe,%eax
 9d3:	cd 40                	int    $0x40
 9d5:	c3                   	ret    

000009d6 <halt>:
SYSCALL(halt)
 9d6:	b8 16 00 00 00       	mov    $0x16,%eax
 9db:	cd 40                	int    $0x40
 9dd:	c3                   	ret    

000009de <toggle>:
SYSCALL(toggle)
 9de:	b8 17 00 00 00       	mov    $0x17,%eax
 9e3:	cd 40                	int    $0x40
 9e5:	c3                   	ret    

000009e6 <ps>:
SYSCALL(ps)
 9e6:	b8 18 00 00 00       	mov    $0x18,%eax
 9eb:	cd 40                	int    $0x40
 9ed:	c3                   	ret    

000009ee <create_container>:
SYSCALL(create_container)
 9ee:	b8 1c 00 00 00       	mov    $0x1c,%eax
 9f3:	cd 40                	int    $0x40
 9f5:	c3                   	ret    

000009f6 <destroy_container>:
SYSCALL(destroy_container)
 9f6:	b8 19 00 00 00       	mov    $0x19,%eax
 9fb:	cd 40                	int    $0x40
 9fd:	c3                   	ret    

000009fe <join_container>:
SYSCALL(join_container)
 9fe:	b8 1a 00 00 00       	mov    $0x1a,%eax
 a03:	cd 40                	int    $0x40
 a05:	c3                   	ret    

00000a06 <leave_container>:
SYSCALL(leave_container)
 a06:	b8 1b 00 00 00       	mov    $0x1b,%eax
 a0b:	cd 40                	int    $0x40
 a0d:	c3                   	ret    

00000a0e <send>:
SYSCALL(send)
 a0e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 a13:	cd 40                	int    $0x40
 a15:	c3                   	ret    

00000a16 <recv>:
SYSCALL(recv)
 a16:	b8 1e 00 00 00       	mov    $0x1e,%eax
 a1b:	cd 40                	int    $0x40
 a1d:	c3                   	ret    

00000a1e <getcid>:
SYSCALL(getcid)
 a1e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 a23:	cd 40                	int    $0x40
 a25:	c3                   	ret    
 a26:	66 90                	xchg   %ax,%ax
 a28:	66 90                	xchg   %ax,%ax
 a2a:	66 90                	xchg   %ax,%ax
 a2c:	66 90                	xchg   %ax,%ax
 a2e:	66 90                	xchg   %ax,%ax

00000a30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	57                   	push   %edi
 a34:	56                   	push   %esi
 a35:	53                   	push   %ebx
 a36:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a39:	85 d2                	test   %edx,%edx
{
 a3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 a3e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 a40:	79 76                	jns    ab8 <printint+0x88>
 a42:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 a46:	74 70                	je     ab8 <printint+0x88>
    x = -xx;
 a48:	f7 d8                	neg    %eax
    neg = 1;
 a4a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 a51:	31 f6                	xor    %esi,%esi
 a53:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 a56:	eb 0a                	jmp    a62 <printint+0x32>
 a58:	90                   	nop
 a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 a60:	89 fe                	mov    %edi,%esi
 a62:	31 d2                	xor    %edx,%edx
 a64:	8d 7e 01             	lea    0x1(%esi),%edi
 a67:	f7 f1                	div    %ecx
 a69:	0f b6 92 bc 0e 00 00 	movzbl 0xebc(%edx),%edx
  }while((x /= base) != 0);
 a70:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 a72:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 a75:	75 e9                	jne    a60 <printint+0x30>
  if(neg)
 a77:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 a7a:	85 c0                	test   %eax,%eax
 a7c:	74 08                	je     a86 <printint+0x56>
    buf[i++] = '-';
 a7e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 a83:	8d 7e 02             	lea    0x2(%esi),%edi
 a86:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 a8a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
 a90:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 a93:	83 ec 04             	sub    $0x4,%esp
 a96:	83 ee 01             	sub    $0x1,%esi
 a99:	6a 01                	push   $0x1
 a9b:	53                   	push   %ebx
 a9c:	57                   	push   %edi
 a9d:	88 45 d7             	mov    %al,-0x29(%ebp)
 aa0:	e8 b1 fe ff ff       	call   956 <write>

  while(--i >= 0)
 aa5:	83 c4 10             	add    $0x10,%esp
 aa8:	39 de                	cmp    %ebx,%esi
 aaa:	75 e4                	jne    a90 <printint+0x60>
    putc(fd, buf[i]);
}
 aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 aaf:	5b                   	pop    %ebx
 ab0:	5e                   	pop    %esi
 ab1:	5f                   	pop    %edi
 ab2:	5d                   	pop    %ebp
 ab3:	c3                   	ret    
 ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 ab8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 abf:	eb 90                	jmp    a51 <printint+0x21>
 ac1:	eb 0d                	jmp    ad0 <printf>
 ac3:	90                   	nop
 ac4:	90                   	nop
 ac5:	90                   	nop
 ac6:	90                   	nop
 ac7:	90                   	nop
 ac8:	90                   	nop
 ac9:	90                   	nop
 aca:	90                   	nop
 acb:	90                   	nop
 acc:	90                   	nop
 acd:	90                   	nop
 ace:	90                   	nop
 acf:	90                   	nop

00000ad0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	57                   	push   %edi
 ad4:	56                   	push   %esi
 ad5:	53                   	push   %ebx
 ad6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ad9:	8b 75 0c             	mov    0xc(%ebp),%esi
 adc:	0f b6 1e             	movzbl (%esi),%ebx
 adf:	84 db                	test   %bl,%bl
 ae1:	0f 84 b3 00 00 00    	je     b9a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 ae7:	8d 45 10             	lea    0x10(%ebp),%eax
 aea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 aed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 aef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 af2:	eb 2f                	jmp    b23 <printf+0x53>
 af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 af8:	83 f8 25             	cmp    $0x25,%eax
 afb:	0f 84 a7 00 00 00    	je     ba8 <printf+0xd8>
  write(fd, &c, 1);
 b01:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 b04:	83 ec 04             	sub    $0x4,%esp
 b07:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 b0a:	6a 01                	push   $0x1
 b0c:	50                   	push   %eax
 b0d:	ff 75 08             	pushl  0x8(%ebp)
 b10:	e8 41 fe ff ff       	call   956 <write>
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 b1b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 b1f:	84 db                	test   %bl,%bl
 b21:	74 77                	je     b9a <printf+0xca>
    if(state == 0){
 b23:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 b25:	0f be cb             	movsbl %bl,%ecx
 b28:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b2b:	74 cb                	je     af8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b2d:	83 ff 25             	cmp    $0x25,%edi
 b30:	75 e6                	jne    b18 <printf+0x48>
      if(c == 'd'){
 b32:	83 f8 64             	cmp    $0x64,%eax
 b35:	0f 84 05 01 00 00    	je     c40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 b3b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 b41:	83 f9 70             	cmp    $0x70,%ecx
 b44:	74 72                	je     bb8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 b46:	83 f8 73             	cmp    $0x73,%eax
 b49:	0f 84 99 00 00 00    	je     be8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 b4f:	83 f8 63             	cmp    $0x63,%eax
 b52:	0f 84 08 01 00 00    	je     c60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 b58:	83 f8 25             	cmp    $0x25,%eax
 b5b:	0f 84 ef 00 00 00    	je     c50 <printf+0x180>
  write(fd, &c, 1);
 b61:	8d 45 e7             	lea    -0x19(%ebp),%eax
 b64:	83 ec 04             	sub    $0x4,%esp
 b67:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 b6b:	6a 01                	push   $0x1
 b6d:	50                   	push   %eax
 b6e:	ff 75 08             	pushl  0x8(%ebp)
 b71:	e8 e0 fd ff ff       	call   956 <write>
 b76:	83 c4 0c             	add    $0xc,%esp
 b79:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 b7c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 b7f:	6a 01                	push   $0x1
 b81:	50                   	push   %eax
 b82:	ff 75 08             	pushl  0x8(%ebp)
 b85:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b88:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 b8a:	e8 c7 fd ff ff       	call   956 <write>
  for(i = 0; fmt[i]; i++){
 b8f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 b93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 b96:	84 db                	test   %bl,%bl
 b98:	75 89                	jne    b23 <printf+0x53>
    }
  }
}
 b9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b9d:	5b                   	pop    %ebx
 b9e:	5e                   	pop    %esi
 b9f:	5f                   	pop    %edi
 ba0:	5d                   	pop    %ebp
 ba1:	c3                   	ret    
 ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 ba8:	bf 25 00 00 00       	mov    $0x25,%edi
 bad:	e9 66 ff ff ff       	jmp    b18 <printf+0x48>
 bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 bb8:	83 ec 0c             	sub    $0xc,%esp
 bbb:	b9 10 00 00 00       	mov    $0x10,%ecx
 bc0:	6a 00                	push   $0x0
 bc2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 bc5:	8b 45 08             	mov    0x8(%ebp),%eax
 bc8:	8b 17                	mov    (%edi),%edx
 bca:	e8 61 fe ff ff       	call   a30 <printint>
        ap++;
 bcf:	89 f8                	mov    %edi,%eax
 bd1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bd4:	31 ff                	xor    %edi,%edi
        ap++;
 bd6:	83 c0 04             	add    $0x4,%eax
 bd9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 bdc:	e9 37 ff ff ff       	jmp    b18 <printf+0x48>
 be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 be8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 beb:	8b 08                	mov    (%eax),%ecx
        ap++;
 bed:	83 c0 04             	add    $0x4,%eax
 bf0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 bf3:	85 c9                	test   %ecx,%ecx
 bf5:	0f 84 8e 00 00 00    	je     c89 <printf+0x1b9>
        while(*s != 0){
 bfb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 bfe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 c00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 c02:	84 c0                	test   %al,%al
 c04:	0f 84 0e ff ff ff    	je     b18 <printf+0x48>
 c0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 c0d:	89 de                	mov    %ebx,%esi
 c0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 c15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 c18:	83 ec 04             	sub    $0x4,%esp
          s++;
 c1b:	83 c6 01             	add    $0x1,%esi
 c1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 c21:	6a 01                	push   $0x1
 c23:	57                   	push   %edi
 c24:	53                   	push   %ebx
 c25:	e8 2c fd ff ff       	call   956 <write>
        while(*s != 0){
 c2a:	0f b6 06             	movzbl (%esi),%eax
 c2d:	83 c4 10             	add    $0x10,%esp
 c30:	84 c0                	test   %al,%al
 c32:	75 e4                	jne    c18 <printf+0x148>
 c34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 c37:	31 ff                	xor    %edi,%edi
 c39:	e9 da fe ff ff       	jmp    b18 <printf+0x48>
 c3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 c40:	83 ec 0c             	sub    $0xc,%esp
 c43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c48:	6a 01                	push   $0x1
 c4a:	e9 73 ff ff ff       	jmp    bc2 <printf+0xf2>
 c4f:	90                   	nop
  write(fd, &c, 1);
 c50:	83 ec 04             	sub    $0x4,%esp
 c53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 c56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 c59:	6a 01                	push   $0x1
 c5b:	e9 21 ff ff ff       	jmp    b81 <printf+0xb1>
        putc(fd, *ap);
 c60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 c63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 c66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 c68:	6a 01                	push   $0x1
        ap++;
 c6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 c6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 c70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 c73:	50                   	push   %eax
 c74:	ff 75 08             	pushl  0x8(%ebp)
 c77:	e8 da fc ff ff       	call   956 <write>
        ap++;
 c7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 c7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c82:	31 ff                	xor    %edi,%edi
 c84:	e9 8f fe ff ff       	jmp    b18 <printf+0x48>
          s = "(null)";
 c89:	bb b5 0e 00 00       	mov    $0xeb5,%ebx
        while(*s != 0){
 c8e:	b8 28 00 00 00       	mov    $0x28,%eax
 c93:	e9 72 ff ff ff       	jmp    c0a <printf+0x13a>
 c98:	66 90                	xchg   %ax,%ax
 c9a:	66 90                	xchg   %ax,%ax
 c9c:	66 90                	xchg   %ax,%ax
 c9e:	66 90                	xchg   %ax,%ax

00000ca0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ca0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ca1:	a1 30 13 00 00       	mov    0x1330,%eax
{
 ca6:	89 e5                	mov    %esp,%ebp
 ca8:	57                   	push   %edi
 ca9:	56                   	push   %esi
 caa:	53                   	push   %ebx
 cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 cae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cb8:	39 c8                	cmp    %ecx,%eax
 cba:	8b 10                	mov    (%eax),%edx
 cbc:	73 32                	jae    cf0 <free+0x50>
 cbe:	39 d1                	cmp    %edx,%ecx
 cc0:	72 04                	jb     cc6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cc2:	39 d0                	cmp    %edx,%eax
 cc4:	72 32                	jb     cf8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 cc6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 cc9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ccc:	39 fa                	cmp    %edi,%edx
 cce:	74 30                	je     d00 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 cd0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 cd3:	8b 50 04             	mov    0x4(%eax),%edx
 cd6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 cd9:	39 f1                	cmp    %esi,%ecx
 cdb:	74 3a                	je     d17 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 cdd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 cdf:	a3 30 13 00 00       	mov    %eax,0x1330
}
 ce4:	5b                   	pop    %ebx
 ce5:	5e                   	pop    %esi
 ce6:	5f                   	pop    %edi
 ce7:	5d                   	pop    %ebp
 ce8:	c3                   	ret    
 ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cf0:	39 d0                	cmp    %edx,%eax
 cf2:	72 04                	jb     cf8 <free+0x58>
 cf4:	39 d1                	cmp    %edx,%ecx
 cf6:	72 ce                	jb     cc6 <free+0x26>
{
 cf8:	89 d0                	mov    %edx,%eax
 cfa:	eb bc                	jmp    cb8 <free+0x18>
 cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 d00:	03 72 04             	add    0x4(%edx),%esi
 d03:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d06:	8b 10                	mov    (%eax),%edx
 d08:	8b 12                	mov    (%edx),%edx
 d0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d0d:	8b 50 04             	mov    0x4(%eax),%edx
 d10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d13:	39 f1                	cmp    %esi,%ecx
 d15:	75 c6                	jne    cdd <free+0x3d>
    p->s.size += bp->s.size;
 d17:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 d1a:	a3 30 13 00 00       	mov    %eax,0x1330
    p->s.size += bp->s.size;
 d1f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d22:	8b 53 f8             	mov    -0x8(%ebx),%edx
 d25:	89 10                	mov    %edx,(%eax)
}
 d27:	5b                   	pop    %ebx
 d28:	5e                   	pop    %esi
 d29:	5f                   	pop    %edi
 d2a:	5d                   	pop    %ebp
 d2b:	c3                   	ret    
 d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d30:	55                   	push   %ebp
 d31:	89 e5                	mov    %esp,%ebp
 d33:	57                   	push   %edi
 d34:	56                   	push   %esi
 d35:	53                   	push   %ebx
 d36:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d3c:	8b 15 30 13 00 00    	mov    0x1330,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d42:	8d 78 07             	lea    0x7(%eax),%edi
 d45:	c1 ef 03             	shr    $0x3,%edi
 d48:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 d4b:	85 d2                	test   %edx,%edx
 d4d:	0f 84 9d 00 00 00    	je     df0 <malloc+0xc0>
 d53:	8b 02                	mov    (%edx),%eax
 d55:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 d58:	39 cf                	cmp    %ecx,%edi
 d5a:	76 6c                	jbe    dc8 <malloc+0x98>
 d5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 d62:	bb 00 10 00 00       	mov    $0x1000,%ebx
 d67:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 d6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 d71:	eb 0e                	jmp    d81 <malloc+0x51>
 d73:	90                   	nop
 d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d7a:	8b 48 04             	mov    0x4(%eax),%ecx
 d7d:	39 f9                	cmp    %edi,%ecx
 d7f:	73 47                	jae    dc8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d81:	39 05 30 13 00 00    	cmp    %eax,0x1330
 d87:	89 c2                	mov    %eax,%edx
 d89:	75 ed                	jne    d78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 d8b:	83 ec 0c             	sub    $0xc,%esp
 d8e:	56                   	push   %esi
 d8f:	e8 2a fc ff ff       	call   9be <sbrk>
  if(p == (char*)-1)
 d94:	83 c4 10             	add    $0x10,%esp
 d97:	83 f8 ff             	cmp    $0xffffffff,%eax
 d9a:	74 1c                	je     db8 <malloc+0x88>
  hp->s.size = nu;
 d9c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 d9f:	83 ec 0c             	sub    $0xc,%esp
 da2:	83 c0 08             	add    $0x8,%eax
 da5:	50                   	push   %eax
 da6:	e8 f5 fe ff ff       	call   ca0 <free>
  return freep;
 dab:	8b 15 30 13 00 00    	mov    0x1330,%edx
      if((p = morecore(nunits)) == 0)
 db1:	83 c4 10             	add    $0x10,%esp
 db4:	85 d2                	test   %edx,%edx
 db6:	75 c0                	jne    d78 <malloc+0x48>
        return 0;
  }
}
 db8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 dbb:	31 c0                	xor    %eax,%eax
}
 dbd:	5b                   	pop    %ebx
 dbe:	5e                   	pop    %esi
 dbf:	5f                   	pop    %edi
 dc0:	5d                   	pop    %ebp
 dc1:	c3                   	ret    
 dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 dc8:	39 cf                	cmp    %ecx,%edi
 dca:	74 54                	je     e20 <malloc+0xf0>
        p->s.size -= nunits;
 dcc:	29 f9                	sub    %edi,%ecx
 dce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 dd1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 dd4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 dd7:	89 15 30 13 00 00    	mov    %edx,0x1330
}
 ddd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 de0:	83 c0 08             	add    $0x8,%eax
}
 de3:	5b                   	pop    %ebx
 de4:	5e                   	pop    %esi
 de5:	5f                   	pop    %edi
 de6:	5d                   	pop    %ebp
 de7:	c3                   	ret    
 de8:	90                   	nop
 de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 df0:	c7 05 30 13 00 00 34 	movl   $0x1334,0x1330
 df7:	13 00 00 
 dfa:	c7 05 34 13 00 00 34 	movl   $0x1334,0x1334
 e01:	13 00 00 
    base.s.size = 0;
 e04:	b8 34 13 00 00       	mov    $0x1334,%eax
 e09:	c7 05 38 13 00 00 00 	movl   $0x0,0x1338
 e10:	00 00 00 
 e13:	e9 44 ff ff ff       	jmp    d5c <malloc+0x2c>
 e18:	90                   	nop
 e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 e20:	8b 08                	mov    (%eax),%ecx
 e22:	89 0a                	mov    %ecx,(%edx)
 e24:	eb b1                	jmp    dd7 <malloc+0xa7>
