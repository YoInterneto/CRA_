; Booleanos. Son los únicos lambda términos no currificados.

(define true (lambda (x y) x))

(define false (lambda (x y) y))

(define neg (lambda (x) (x false true)))
                         
(define and (lambda (x y) (x y false)))

(define or (lambda (x y) (x true y)))

; Pares ordenados
              
(define par (lambda (x)
              (lambda (y)
                (lambda (f) (f x y)))))

(define primero (lambda (p) (p true)))

(define segundo (lambda (p) (p false)))

;;;;; Combinador de punto fijo

(define Y
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;;;;;; Orden en naturales y test de nulidad 

(define esmenoroigualnat (lambda (n)
                             (lambda (m)
                                (escero ((restanat n) m)))))
                         
(define esmayoroigualnat (lambda (n)
                            (lambda (m)
                               (escero ((restanat m) n)))))
                         
(define esmenornat (lambda (n)
                     (lambda (m)
                       (and ((esmenoroigualnat n) m) (noescero ((restanat m) n))))))

(define esmayornat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) (noescero ((restanat n) m))))))

(define esigualnat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) ((esmenoroigualnat n) m)))))

(define escero (lambda (n)
                 ((n (lambda (x) false)) true)))

(define noescero (lambda (n)
                    (neg (escero n))))

; Aritmética natural. Se define también "comprobar" para poder hacer pruebas. Se definen algunos naturales para hacer comprobaciones. Se escriben en francés para distinguirlos de los enteros 
; que se escribirán en español.

(define zero (lambda (f)
               (lambda (x) x)))

(define sucesor (lambda (n)
                  (lambda (f)
                    (lambda (x)
                     (f((n f) x))))))

(define un (sucesor zero))

(define deux (sucesor un))

(define trois (sucesor deux))

(define quatre (sucesor trois))

(define cinq (sucesor quatre))

(define six (sucesor cinq))

(define sept (sucesor six))

(define huit (sucesor sept))

(define neuf (sucesor huit))

(define dix (sucesor neuf))

(define onze (sucesor dix))

(define douze (sucesor onze))

(define treize (sucesor douze))

(define quatorze (sucesor treize))

(define quinze (sucesor quatorze))

(define seize (sucesor quinze))

(define dix-sept (sucesor seize))

(define dix-huit (sucesor dix-sept))

(define dix-neuf (sucesor dix-huit))

(define vingt (sucesor dix-neuf))

;; Comprobar

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

;; Suma naturales

(define sumnat (lambda (n)
                 (lambda (m)
                   ((n (lambda (x) (sucesor x))) m))))

;; Producto naturales

(define prodnat (lambda (n)
                   (lambda (m)
                     (lambda (f)
                       (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

;; Predecesor y resta 

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                            (segundo ((n ((lambda (g)
                                             (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                     (lambda (m)
                        ((m (lambda (x) (predecesor x))) n))))                                                 

;; Resto de la división euclídea. Si el divisor es cero, devuelve false.

(define restonataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                 (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (f ((restanat x) m))
                        )
                        (lambda (no_use)
                            x
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
))

(define restonat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((restonataux n) m))) zero))))

;; Cociente de la división euclídea. Al igual que el resto, devuelve false si se divide por cero.

(define cocientenataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (sucesor (f ((restanat x) m)))  
                        )
                        (lambda (no_use)
                            zero
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
    )
)

(define cocientenat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((cocientenataux n) m))) zero))))

;; Máximo común denominador.

(define mcdnat
    (lambda (n)
        (lambda (m)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda(y)
                      (((escero y)  
                       (lambda (no_use)
                            x
                        ) 
                       (lambda (no_use)
                            ((f y)((restonat x) y)) 
                        )
                        
                    )
                        zero)    ; Pasa zero como argumento de no_use
                ))
            ))
                n) ; Pasa n como el valor inicial de x.
          m)       ; Pasa m como el valor inicial de y.
    )
))

;;;; Paridad

(define par? (lambda (n)
               (escero ((restonat n) deux))))

(define cuadrado (lambda (n)
                   ((prodnat n) n)))


;;;;; Potencias de naturales usando algo binario.

(define potencianat
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (y)
                    (((escero y)
                        (lambda (no_use)
                            un
                        )
                        (lambda (no_use)
                          (((par? y)
                           (lambda (no_use1)
                             (cuadrado (f ((cocientenat y) deux))))
                           (lambda (no_use1)
                             ((prodnat n) (f (predecesor y))))) zero)
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                m)  ; Pasa n como el valor inicial de x.
        )
    )
)

;;;;;; Definición de algunos enteros. Se codifican los enteros mediante pares de naturales: el par (m,n) es una representación de m-n. Es obvio que varios
;;;;;; pares codifican el mismo entero. Por ejemplo, (7,5)=(9,7). Por lo tanto, los enteros se definen como el conjunto cociente de NxN mediante la relación 
;;;;;; de equivalencia R dada por
;;;;;;
;;;;;;                     (m,n) R (m',n') si y solo si m-n=m'-n'

(define cero ((par zero) zero))

(define -uno ((par zero) un))

(define -dos ((par zero) deux))

(define -tres ((par zero) trois))

(define -cuatro ((par zero) quatre))

(define -cinco ((par zero) cinq))

(define -seis ((par zero) six))

(define -siete ((par zero) sept))

(define -ocho ((par zero) huit))

(define -nueve ((par zero) neuf))

(define -diez ((par zero) dix))

(define -once ((par zero) onze))

(define -doce ((par zero) douze))

(define -trece ((par zero) treize))

(define -catorce ((par zero) quatorze))

(define -quince ((par zero) quinze))

(define -dieciseis ((par zero) seize))

(define -diecisiete ((par zero) dix-sept))

(define -dieciocho ((par zero) dix-huit))

(define -diecinueve ((par zero) dix-neuf))

(define -veinte ((par zero) vingt))

(define uno ((par un) zero))

(define dos ((par deux) zero))

(define tres ((par trois) zero))

(define cuatro ((par quatre) zero))

(define cinco ((par cinq) zero))

(define seis ((par six) zero))

(define siete ((par sept) zero))

(define ocho ((par huit) zero))

(define nueve ((par neuf) zero))

(define diez ((par dix) zero))

(define once ((par onze) zero))

(define doce ((par douze) zero))

(define trece ((par treize) zero))

(define catorce ((par quatorze) zero))

(define quince ((par quinze) zero))

(define dieciseis ((par seize) zero))

(define diecisiete ((par dix-sept) zero))

(define dieciocho ((par dix-huit) zero))

(define diecinueve ((par dix-neuf) zero))

(define veinte ((par vingt) zero))

;;;;;;;;;;;;
(define dostercios ((cocientenat deux) trois))

;;;;; Orden, valor absoluto y tests de nulidad, positividad y negatividad. 
;;;
;;; m-n > m'-n' si y solo si m+n' > m'+n e igual con el resto

(define esmayoroigualent (lambda (r)
                           (lambda (s)
                             ((esmayoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r)))))) 

(define esmenoroigualent (lambda (r)
                           (lambda (s)
                             ((esmenoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmayorent (lambda (r)
                           (lambda (s)
                             ((esmayornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmenorent (lambda (r)
                           (lambda (s)
                             ((esmenornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esigualent (lambda (r)
                           (lambda (s)
                             ((esigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define absoluto (lambda (r)
                    (((esmayoroigualnat (primero r)) (segundo r)) ((par ((restanat (primero r)) (segundo r))) zero) ((par ((restanat (segundo r)) (primero r))) zero))))

(define negativo (lambda (r)
                   ((esmenorent r) cero)))

(define positivo (lambda (r)
                   ((esmayorent r) cero)))

(define esceroent (lambda (r)
                     ((esigualnat (primero r)) (segundo r))))
                      
(define noesceroent (lambda (r)
                       (neg (esceroent r))))

;;;;; Reducción a representante canónico de la clase de equivalencia.

(define reducir (lambda (r)
                  (((esmayoroigualnat (primero r)) (segundo r)) 
                        ((par ((restanat (primero r)) (segundo r))) zero)
                        ((par zero) ((restanat (segundo r)) (primero r))))))

;;;;; Aritmética entera. La respuesta está siempre dada por el representante canónico de la clase de equivalencia. 

(define testenteros (lambda (r)
                      (- (comprobar (primero r)) (comprobar (segundo r)))))

(define sument (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat (primero r)) (primero s))) ((sumnat (segundo r)) (segundo s)))))))

(define prodent (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat ((prodnat (primero r)) (primero s))) ((prodnat (segundo r)) (segundo s))))
                          ((sumnat ((prodnat (primero r)) (segundo s))) ((prodnat (segundo r)) (primero s))))))))                       

(define restaent (lambda (r)
                   (lambda (s)
                     (reducir ((par ((sumnat (primero r)) (segundo s))) ((sumnat (segundo r)) (primero s)))))))

(define opuesto (lambda (r)
                  ((par (segundo r)) (primero r))))

;; Lo siguiente reduce la división de enteros a división de naturales. Si m mayor o igual que 0 y n > 0, y si q y r son cociente y resto de la división de m entre n, se tiene
;;  m  = q       * n        + r
;;  m  = (-q)    * (-n)     + r
;; -m  = (-(q+1))* n        + (n-r)
;; -m  = (q+1)   * (-n)     + (n-r),
;; siempre y cuando el resto no sea cero. Cuando el divisor es cero, la función cocienteent devuelve false.

(define cocienteent_aux (lambda (r)
                          (lambda (s)
                            ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))

; Caso1: resto cero. Si m= q*n, entonces -m= (-q)*n, -m = q* (-n) y m= (-q)*(-n).

(define cocienteentaux-caso1 (lambda (r)
                               (lambda (s)
                                  ((or (and ((esmayoroigualent r) cero) (positivo s)) (and (negativo r) (negativo s))) ((par ((cocientenat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                       ((par zero) ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))))
                              
; Caso 2: resto no nulo

(define cocienteentaux-caso2 (lambda (r)
                                (lambda (s)
                                    (((esmayoroigualent r) cero) ((positivo s) ((par ((cocienteent_aux r) s)) zero) ((par zero) ((cocienteent_aux r) s)))
                                                                 ((positivo s) ((par zero) (sucesor ((cocienteent_aux r) s))) ((par (sucesor ((cocienteent_aux r) s))) zero))))))
; Cociente cuando no hay división por cero

(define cocienteentaux (lambda (r)
                         (lambda (s)
                           ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) ((cocienteentaux-caso1 r) s) ((cocienteentaux-caso2 r) s)))))

; Cociente considerando la división por cero

(define cocienteent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((cocienteentaux r) s))) zero))))

; Resto. Si se divide por cero, devuelve false

(define restoentaux1 (lambda (r)
                        (lambda (s)
                          ((or (and ((esmayoroigualent r) cero) (positivo s)) (and ((esmayoroigualent r) cero) (negativo s))) ((par ((restonat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                           ((par ((restanat (primero (absoluto s)))((restonat (primero (absoluto r))) (primero (absoluto s))))) zero)))))

(define restoentaux (lambda (r)
                       (lambda (s)
                          ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) cero ((restoentaux1 r) s)))))

(define restoent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((restoentaux r) s))) zero))))

;; Como mcd (r,s)=mcd(|r|,|s|), se tiene

(define mcdent (lambda (r)
                 (lambda (s)
                   ((par ((mcdnat (primero (absoluto r))) (primero (absoluto s)))) zero))))

;; Mínimo común múltiplo

(define mcment (lambda (r)
                 (lambda (s)
                   ((cocienteent ((prodent r) s)) ((mcdent r) s)))))



;--------------------------------------------------------------

;Definicion de racionales
(define unmedio ((par uno) dos))
(define tresmedios ((par tres) dos))
(define dostercios ((par dos) tres))
(define trescuartos ((par tres) cuatro))
(define untercio ((par uno) tres))
(define unquinto ((par uno) cinco))
(define dosquintos ((par dos) cinco))
(define cincosextos ((par cinco) seis))
(define uncuarto ((par uno) cuatro))
(define cincoseptimos ((par cinco) siete))
(define doscuartos ((par dos) cuatro))
(define tressextos ((par tres) seis))
(define cincodecimos ((par cinco) diez))
(define dosmedios ((par dos) dos))
(define tresnovenos ((par tres) nueve))
(define -unouno ((par -uno) uno))





(define test_racionales (lambda(r)
                    (list(testenteros (primero r))(testenteros (segundo r)))))




;a) Representante canonico 

(define rep_canonico_racionales (lambda (r)
                         ((par ((cocienteent (primero r) ) ((mcdent (primero r)) (segundo r)) ))
                          ((cocienteent (segundo r) ) ((mcdent (primero r)) (segundo r)) ))))


;b)
;Suma
;Se halla el mcm de los denominadores, despues se hace la division del mcm con cada denominador y se multiplica a cada numerador. Despues se suman los numeradores y se deja el mcm como denominador
;Despues de la suma se aplica el representante canonico para hacer la fraccion irreducible
;Por ejemplo, 1/2 + 2/3 --> mcm(2,3)=6, por lo tanto 6/2=3, 3*1=3 y 6/3=2, 2*2=4 por lo tanto se suman 3+4=7 (numerador) y el denominador es 6

(define suma_racionales  (lambda (r1)
                   (lambda(r2)
                      (rep_canonico_racionales ((par ((sument
                              ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                             ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))))
                       ((mcment (segundo r1)) (segundo r2)))))))

;Producto
;Se multiplican los numeradores y los denaminadores y se hace el representante canonico
(define prod_racionales  (lambda (r1)
                   (lambda(r2)
                      (rep_canonico_racionales ((par ((prodent (primero r1)) (primero r2))) ((prodent (segundo r1)) (segundo r2)))))))

;Resta
;Lo mismo que la suma pero aplicando resta
(define resta_racionales  (lambda (r1)
                   (lambda(r2)
                      (rep_canonico_racionales ((par ((restaent
                              ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                             ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))))
                       ((mcment (segundo r1)) (segundo r2)))))))

;Inversa
;Se intercambian el numerador y el denominador
(define inverso_racionales  (lambda (r)
                         (rep_canonico_racionales ((par (segundo r)) (primero r)))))


;c)
;Mayor o igual
;Hacemos el mcd de los dos numeros (aplicamos el mismo procedimiento que en la suma) y comparamos el numerador
(define mayor_igual_racional? (lambda (r1)
                               (lambda (r2)
                                  (((esmayoroigualent
                                     ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                                    ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))) "mayor o igual" "menor"))))

;Mayor
(define mayor_racional? (lambda (r1)
                               (lambda (r2)
                                  (((esmayorent
                                     ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                                    ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))) "mayor" "menor o igual"))))

;Menor o igual
(define menor_igual_racional? (lambda (r1)
                               (lambda (r2)
                                  (((esmenoroigualent
                                     ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                                    ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))) "menor o igual" "mayor"))))

;Menor

(define menor_racional? (lambda (r1)
                               (lambda (r2)
                                  (((esmenorent
                                     ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                                    ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))) "menor" "mayor o igual"))))

;Igual
(define iguales_racional? (lambda (r1)
                               (lambda (r2)
                                  (((esigualent
                                     ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r1))) (primero r1)))
                                    ((prodent ((cocienteent ((mcment (segundo r1)) (segundo r2))) (segundo r2))) (primero r2))) "iguales" "diferentes"))))



;Test representante canonico
;(test_racionales (rep_canonico_racionales cincodecimos))

;Test suma racionales
;(test_racionales  ((suma_racionales unmedio) dosmedios))
;(test_racionales  ((suma_racionales unmedio) dostercios))

;Test producto racionales
;(test_racionales  ((prod_racionales unmedio) dostercios))
;(test_racionales  ((prod_racionales cincodecimos) tressextos))
;(test_racionales  ((prod_racionales untercio) cincosextos))

;Test resta racionales
;(test_racionales  ((resta_racionales unmedio) dosmedios))
;(test_racionales  ((resta_racionales unmedio) dostercios))
;(test_racionales  ((resta_racionales cincoseptimos) dostercios))

;Test inversa
;(test_racionales (inverso_racionales cincodecimos))
;(test_racionales (inverso_racionales tresnovenos))
;(test_racionales (inverso_racionales untercio))

;Test mayor o igual
;((mayor_igual_racional? unmedio) dostercios)
;((mayor_igual_racional? trescuartos) dostercios)
;((mayor_igual_racional? unmedio) trescuartos)
;((mayor_igual_racional? dosmedios) dostercios)
;((mayor_igual_racional? unmedio) cincodecimos)

;Test mayor
;((mayor_racional? unmedio) dostercios)
;((mayor_racional? trescuartos) dostercios)
;((mayor_racional? unmedio) trescuartos)
;((mayor_racional? dosmedios) dostercios)
;((mayor_racional? unmedio) cincodecimos)

;Test menor o igual
;((menor_igual_racional? unmedio) dostercios)
;((menor_igual_racional? trescuartos) dostercios)
;((menor_igual_racional? unmedio) trescuartos)
;((menor_igual_racional? dosmedios) dostercios)
;((menor_igual_racional? unmedio) cincodecimos)

;Test menor
;((menor_racional? unmedio) dostercios)
;((menor_racional? trescuartos) dostercios)
;((menor_racional? unmedio) trescuartos)
;((menor_racional? dosmedios) dostercios)
;((menor_racional? unmedio) cincodecimos)

;Test igual
;((iguales_racional? unmedio) dostercios)
;((iguales_racional? trescuartos) dostercios)
;((iguales_racional? unmedio) trescuartos)
;((iguales_racional? dosmedios) dostercios)
;((iguales_racional? unmedio) cincodecimos)




;MATRICES RACIONALES

(define definir_matriz (lambda (a)
                         (lambda (b)
                           (lambda (c)
                             (lambda (d)
                               ((par ((par a) b)) ((par c) d)))))))


(define test_matriz (lambda (m)
                        (list (list (test_racionales (primero (primero m))) (test_racionales (segundo (primero m))))
                              (list (test_racionales (primero (segundo m))) (test_racionales (segundo (segundo m))))
                        )
                      )
)

;Definicion matrices
(define identidad ((((definir_matriz ((par uno) uno)) ((par cero) uno)) ((par cero) uno)) ((par uno) uno)))
(define matriz_nula ((((definir_matriz ((par cero) uno)) ((par cero) uno)) ((par cero) uno)) ((par cero) uno)))
(define matriz_prueba1 ((((definir_matriz ((par dos) cuatro)) ((par cuatro) cuatro)) ((par -uno) cuatro)) ((par cinco) cuatro)))
(define matriz_prueba2 ((((definir_matriz ((par uno) cuatro))   ((par -cuatro) seis))     ((par dos) ocho)) ((par -dos) tres)))
(define matriz_prueba3 ((((definir_matriz ((par uno) dos))   ((par -cuatro) dos))     ((par dos) dos)) ((par -tres) dos)))
(define matriz_prueba4 ((((definir_matriz ((par cero) dos))   ((par cero) dos))     ((par dos) dos)) ((par -tres) dos)))





;a)
;Suma
;Se suman los de cada posicion entre si
(define suma_matrices (lambda (m1)
                                   (lambda(m2)
                                     ((par ((par ((suma_racionales (primero (primero m1)))(primero(primero m2)))) ((suma_racionales (segundo (primero m1)))(segundo(primero m2)))))
                                      ((par ((suma_racionales (primero (segundo m1)))(primero(segundo m2)))) ((suma_racionales (segundo (segundo m1)))(segundo(segundo m2))))))))





;Producto
;Se multiplican las filas de la primera por las columnas de la segunda y en cada posicion se suman
(define prod_matrices (lambda (m1)
                        (lambda(m2)
                            ((par ((par ((suma_racionales ((prod_racionales(primero (primero m1)))(primero(primero m2)))) ((prod_racionales(segundo (primero m1)))(primero(segundo m2)))))
                                   ((suma_racionales ((prod_racionales(primero (primero m1)))(segundo(primero m2)))) ((prod_racionales(segundo (primero m1)))(segundo(segundo m2))))))
                             ((par ((suma_racionales ((prod_racionales(primero (segundo m1)))(primero(primero m2)))) ((prod_racionales(segundo (segundo m1)))(primero(segundo m2)))))
                                   ((suma_racionales ((prod_racionales(primero (segundo m1)))(segundo(primero m2)))) ((prod_racionales(segundo (segundo m1)))(segundo(segundo m2)))))))))







;b)
;Determinante
;Se multplica en cruz y se resta. Importante: el resultado da un numero racional, no una matriz, por lo que hay que hacerlo con test_racionales
(define determinante (lambda (m1)
                           ((resta_racionales ((prod_racionales(primero (primero m1))) (segundo(segundo m1))))
                            ((prod_racionales(segundo (primero m1)))(primero(segundo m1))))))


;c)
;Funciones que usaremos para saber cuando no es cero
(define escero_racional (lambda (r)
                                (esceroent (primero r))))

(define noescero_racional (lambda (r)
                            (neg (escero_racional r))))


 


;Inversibilidad
;Si no es cero, la matriz tendra inversa
(define inversa? (lambda (m)
                       ((noescero_racional (determinante m)) "tiene inversa" "no tiene inversa")))

;Inversa

;Funcion que usaremos para dividir a toda la matriz por el determinante
;Multiplica a toda la matriz por la inversa de un racional, es decir, divide a cada elemento de la matriz entre el racional dado
(define division_matriz_racional (lambda (m) 
                                   (lambda(r) 
                                     ((par ((par ((prod_racionales (primero (primero m))) (inverso_racionales r)))((prod_racionales (segundo (primero m))) (inverso_racionales r))))
                                      ((par ((prod_racionales (primero (segundo m))) (inverso_racionales r)))((prod_racionales (segundo (segundo m))) (inverso_racionales r)))))))

;(test_matriz ((division_matriz_racional matriz_prueba1) unmedio))
;Adjunta
;Se intercambia por el valor de eliminar filas y columnas y multiplicar por -1 en las posiciones impares
(define adjunta_matriz (lambda(m)
                         ((par ((par (rep_canonico_racionales(segundo (segundo m)))) ((prod_racionales (primero (segundo m))) -unouno)))
                          ((par ((prod_racionales (segundo (primero m))) -unouno)) (rep_canonico_racionales(primero (primero m)))))))

;(test_matriz (adjunta_matriz matriz_prueba1))
;Traspuesta
;Se intercambian filas por columnas
(define traspuesta_matriz (lambda (m)
                            ((par ((par (rep_canonico_racionales(primero (primero m)))) (rep_canonico_racionales(primero (segundo m)))))
                          ((par (rep_canonico_racionales(segundo (primero m)))) (rep_canonico_racionales(segundo (segundo m)))))))

;(test_matriz (traspuesta_matriz matriz_prueba1))

;Inversa
;Adjunta de la traspuesta entre el determinante
(define inversa_matriz (lambda (m)
                   ((division_matriz_racional(adjunta_matriz (traspuesta_matriz m))) (determinante m) )))

 

;Rango
;Si el determinante es 0, el rango es 1, si no el rango es 2. Devuelve un entero
(define rango (lambda (m)
                     ((noescero_racional (determinante m)) dos uno)))







  
;Test suma
;(test_matriz ((suma_matrices matriz_prueba1) matriz_prueba2))

;Test producto
;(test_matriz ((prod_matrices matriz_prueba1) matriz_prueba2))

;Test determinante
;(test_racionales (determinante matriz_prueba1))
;(test_racionales (determinante matriz_prueba4))

;Test inversibilidad
;(inversa? matriz_prueba1)
;(inversa? matriz_prueba4)

;Test inversa
;(test_matriz (inversa_matriz matriz_prueba1))
;(test_matriz (inversa_matriz matriz_prueba4))

;Test rango
;(testenteros (rango matriz_prueba1))



 
 







