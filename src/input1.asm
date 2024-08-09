lh x1, 4(x0)        # x1 = Mem[4] (carregando o valor da posição de memória 4 em x1)
add x2, x1, x0      # x2 = x1 + x0 (x2 = x1, pois x0 = 0)

add x1, x1, x2      # x1 = x1 + x2
sll x1, x1, 0       # x1 = x1 << 0 (não altera o valor de x1)
sll x1, x1, 0       # x1 = x1 << 0 (não altera o valor de x1)
sub x1, x1, x2      # x1 = x1 - x2
sub x1, x1, x2      # x1 = x1 - x2

bne x1, x2, SAIDA   # Se x1 != x2, vai para SAIDA

# Caso o fluxo venha para cá, seu processador está errado
add x1, x1, x1      # x1 = x1 + x1
sh x1, 0(x0)        # Mem[0] = x1 (armazenando x1 na posição de memória 0)

SAIDA:
andi x1, x1, x2     # x1 = x1 & x2
or x1, x1, x0       # x1 = x1 | x0
sh x1, 0(x0)        # Mem[0] = x1 (armazenando x1 na posição de memória 0)
