// =======================================================
// ENCLOSURE ULTRA-COMPACTA V16.3 - FURO 8MM CENTRALIZADO OK
// =======================================================

$fn = 64; // Alta resolução para furos e encaixes

// --- PARÂMETROS DA CAIXA ---
espessura_parede = 2.0;
folga_encaixe = 0.3; // Tolerância para encaixe suave
vao_central = 2.0; // Distância entre as duas placas em pé
raio_canto = 3.0; // Raio de arredondamento dos cantos externos

// --- ESPAÇOS INTERNOS DOS TRILHOS (GUIA POR PRESSÃO) ---
espaco_trilho_fonte = 15.0; // Espaço exato interno livre entre os trilhos da fonte
espaco_trilho_esp = 18.0;   // Espaço exato interno livre entre os trilhos da ESP32

// --- DIMENSÕES DAS PLACAS ---
fonte_altura = 20.0 + folga_encaixe; // Altura em pé: 20.3 mm
esp_altura = 18.0 + folga_encaixe;   // Altura em pé: 18.3 mm

fonte_profundo = 34.0 + folga_encaixe; // 34.3 mm
esp_profundo = 25.0 + folga_encaixe;  // 25.3 mm

// --- CÁLCULO DE LARGURA DOS TRILHOS NA BASE ---
aba_trilho = 1.5; // Espessura da parede do trilho
largura_total_trilho_fonte = espaco_trilho_fonte + (aba_trilho * 2); // 18.0 mm
largura_total_trilho_esp = espaco_trilho_esp + (aba_trilho * 2);     // 21.0 mm

// --- DIMENSÕES INTERNAS TOTAIS ---
interno_L = largura_total_trilho_fonte + vao_central + largura_total_trilho_esp; // ~41.0 mm
interno_P = max(fonte_profundo, esp_profundo); // 34.3 mm

// --- ALTURA AJUSTADA PARA COMPENSAR A TAMPA MACIÇA ---
interno_A = 20.5; 
externo_A = interno_A + espessura_parede; // 22.5 mm de altura externa da caixa base

// --- DIMENSÕES EXTERNAS TOTAIS ---
externo_L = interno_L + (espessura_parede * 2);
externo_P = interno_P + (espessura_parede * 2);

// --- COORDENADAS DE ANCORAGEM (Placas em Pé) ---
fonte_X = espessura_parede;
esp_X = externo_L - espessura_parede - largura_total_trilho_esp;

centro_vao_X = espessura_parede + largura_total_trilho_fonte + (vao_central / 2);

// --- CONFIGURAÇÃO DE PARAFUSOS M2 ---
m2_diametro = 2.0;
m2_profundidade = 6.0;
boss_diametro = 5.0; 
boss_altura_frontal = m2_profundidade + 1.5; // 7.5 mm

// =======================================================
// CONTROLE DE VISUALIZAÇÃO
// =======================================================
// Mude para 'false' para gerar a Caixa Base ou 'true' para gerar a Tampa
visualizar_tampa = false; 

if (visualizar_tampa) {
    tampa();
} else {
    caixa_base();
}

// =======================================================
// MÓDULOS AUXILIARES
// =======================================================

// Gera um cubo com cantos arredondados no plano X-Y
module cubo_arredondado(l, p, a, r) {
    translate([r, r, 0])
    minkowski() {
        cube([l - 2*r, p - 2*r, a - 0.1]);
        cylinder(r=r, h=0.1);
    }
}

// Gera trilhos guia laterais onde a placa desliza pelo meio até tocar o fundo
module trilhos_guia_lateral(espaco_interno, profundidade, altura_guia) {
    // Guia Esquerda
    cube([aba_trilho, profundidade, altura_guia]);
    // Guia Direita
    translate([aba_trilho + espaco_interno, 0, 0])
    cube([aba_trilho, profundidade, altura_guia]);
}

// =======================================================
// MÓDULOS DO PROJETO
// =======================================================

module caixa_base() {
    difference() {
        // 1. Corpo Externo Maciço ARREDONDADO
        cubo_arredondado(externo_L, externo_P, externo_A, raio_canto);
        
        // 2. Cavidade Interna Principal (Totalmente desimpedida até o fundo)
        translate([espessura_parede, espessura_parede, espessura_parede])
        cube([interno_L, interno_P, interno_A + 1]);
        
        // 3. Furo USB-C Realístico Arredondado (Horizontal)
        usb_L_folga = 10.0;
        usb_A_folga = 4.5;
        
        pos_usb_x = esp_X + (largura_total_trilho_esp / 2);
        pos_usb_z_centro = espessura_parede + 3.0 + (usb_A_folga / 2); 
        
        translate([pos_usb_x, -1, pos_usb_z_centro])
        rotate([-90, 0, 0]) 
        furo_usbc_perfil(usb_L_folga, usb_A_folga, espessura_parede + 2);
        
        // 4. Furo Frontal de 8mm para Passagem de Fios
        // AJUSTADO: Posicionado para ficar o mais alto possível, iniciando imediatamente abaixo do boss
        pos_furo_8mm_z = (externo_A - boss_altura_frontal) - 4.0; // 11.0 mm (centro perfeito)
        translate([centro_vao_X, -1, pos_furo_8mm_z])
        rotate([-90, 0, 0])
        cylinder(d=8, h=espessura_parede + 3);
        
        // 5. Furos Guia M2 dentro dos Bosses (Cego com 6mm de profundidade)
        translate([centro_vao_X, espessura_parede + (boss_diametro/2) - 1, externo_A - m2_profundidade])
        cylinder(d=m2_diametro, h=m2_profundidade + 1);
        
        translate([centro_vao_X, externo_P - espessura_parede - (boss_diametro/2) + 1, externo_A - m2_profundidade])
        cylinder(d=m2_diametro, h=m2_profundidade + 1);
    }
 
    // 6. Bosses Suspensos para os parafusos M2
    translate([centro_vao_X - (boss_diametro/2), espessura_parede, externo_A - boss_altura_frontal])
    cube([boss_diametro, boss_diametro/2, boss_altura_frontal]);
    
    translate([centro_vao_X - (boss_diametro/2), externo_P - espessura_parede - (boss_diametro/2), externo_A - boss_altura_frontal])
    cube([boss_diametro, boss_diametro/2, boss_altura_frontal]);
    
    // 7. Trilhos Guia de Encaixe por Pressão
    // TRILHO DA FONTE: Reduzido 5mm na frente e 5mm atrás (comprimento = fonte_profundo - 10)
    pos_fonte_Y = espessura_parede + (interno_P - fonte_profundo) + 5.0;
    comp_trilho_fonte = fonte_profundo - 10.0;
    translate([fonte_X, pos_fonte_Y, espessura_parede]) 
        trilhos_guia_lateral(espaco_trilho_fonte, comp_trilho_fonte, 4.0);
        
    // TRILHO DA ESP32: Mantido na profundidade total de sua placa
    translate([esp_X, espessura_parede, espessura_parede]) 
        trilhos_guia_lateral(espaco_trilho_esp, esp_profundo, 4.0);
}

module furo_usbc_perfil(largura, altura, profundidade) {
    raio = altura / 2;
    distancia_centros = largura - altura;
    hull() {
        translate([-distancia_centros/2, 0, 0])
        cylinder(r=raio, h=profundidade);
        translate([distancia_centros/2, 0, 0])
        cylinder(r=raio, h=profundidade);
    }
}

module tampa() {
    difference() {
        // Tampa simplificada: totalmente maciça por baixo (plana), com cantos arredondados
        cubo_arredondado(externo_L, externo_P, espessura_parede, raio_canto);
        
        // Furo Passante M2 Frontal na Tampa
        translate([centro_vao_X, espessura_parede + (boss_diametro/2) - 1, -1]) {
            cylinder(d=2.4, h=espessura_parede + 2);
            translate([0,0, espessura_parede - 1.2]) 
            cylinder(d1=2.4, d2=4.2, h=1.4); 
        }
 
        // Furo M2 Traseiro na Tampa
        translate([centro_vao_X, externo_P - espessura_parede - (boss_diametro/2) + 1, -1]) {
            cylinder(d=2.4, h=espessura_parede + 2);
            translate([0,0, espessura_parede - 1.2]) 
            cylinder(d1=2.4, d2=4.2, h=1.4); 
        }
    }
}