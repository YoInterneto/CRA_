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



;_______________________________________________________________________________________________________________________________________________________________________________________________

;IF
(define if (lambda (p x y) (p x y)))

;_______________________________________________________________________________________________________________________________________________________________________________________________
;Funciones Para Enteros

;Representacion de Canonico
(define canonico_p (lambda (a)
                          (lambda (b)
                            ((restoent a)b))))

;Suma
(define suma_p (lambda (num1)
                      (lambda (num2)
                        (lambda (num3)
                          ((restoent ((sument num1)num2))num3)))))

;Multiplicacion
(define prod_p (lambda (num1)
                                (lambda (num2)
                                  (lambda (num3)
                                    ((restoent ((prodent num1)num2))num3)))))

;Inverso
(define inverso? (lambda (a)
                         (lambda (b)
                           (if ((esigualent ((mcdent a)b))uno) true false))))

(define inverso_p
  (lambda (c)
        (lambda (a)
          (lambda (b)
            ((((Y (lambda (f)
                   (lambda (cont)
                     (lambda(x)
                       (lambda (y)
                      ((((esigualent ((canonico_p ((prodent a)cont))b))uno)  
                       (lambda (no_use)
                            cont
                        ) 
                       (lambda (no_use)
                            (((f ((sument cont)uno))a)b) 
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                 )
                )
               )
              )
             )
          c) 
         a)
        b)
    )
   )
  )
 )


;Pruebas Enteros
;(testenteros ((canonicoEnteros seis)cuatro))
;2

;(testenteros (((sumaEnteros cinco)tres)cuatro))
;0

;(testenteros (((prod_p cinco)tres)cuatro))
;3

;((inversoEnteros cuatro)seis)
;false

;(testenteros (((hacerInversoEnteros cero)dos)cinco))
;3


;_________________________________________________________________________________________
;Matrices
;Test Matriz
(define testmatrices (lambda (matriz)
                        (list (list (testenteros (primero (primero matriz))) (testenteros (segundo (primero matriz))))
                              (list (testenteros (primero (segundo matriz))) (testenteros (segundo (segundo matriz)))))))

;Crear Matriz
(define matriz (lambda (a)
                 (lambda (b)
                   (lambda (c)
                     (lambda (d) 
                       ((par ((par a) b)) ((par c) d)))))))

;Matriz modularizada
(define matrizModularizada (lambda (m)
                             (lambda (modulo)
                               ((par
                                 ((par ((restoent (primero (primero m))) modulo))
                                       ((restoent (segundo (primero m))) modulo)))
                                 ((par ((restoent (primero (segundo m))) modulo)) 
                                       ((restoent (segundo (segundo m))) modulo)))
                               )))

;Suma
(define suma_matrices (lambda (mat1)
                        (lambda (mat2)
                          ((par
                               ((par ((sument (primero (primero mat1))) (primero (primero mat2))))
                                     ((sument (segundo (primero mat1))) (segundo (primero mat2)))))
                               ((par ((sument (primero (segundo mat1))) (primero (segundo mat2)))) 
                                     ((sument (segundo (segundo mat1))) (segundo (segundo mat2)))))
                          )))

;Multiplicacion
(define prod_matrices (lambda (mat1)
                                 (lambda (mat2)
                                   ((par
                                      ((par ((sument ((prodent (primero (primero mat1))) (primero (primero mat2))))
                                                     ((prodent (segundo (primero mat1))) (primero (segundo mat2)))))
                                            ((sument ((prodent (primero (primero mat1))) (segundo (primero mat2))))
                                                     ((prodent (segundo (primero mat1))) (segundo (segundo mat2))))))
                                      ((par ((sument ((prodent (primero (segundo mat1))) (primero (primero mat2))))
                                                     ((prodent (segundo (segundo mat1))) (primero (segundo mat2)))))
                                            ((sument ((prodent (primero (segundo mat1))) (segundo (primero mat2))))
                                                     ((prodent (segundo (segundo mat1))) (segundo (segundo mat2))))))
                                   )))

;Multiplicacion
(define cuadrado_matrices (lambda (mat1)
                                   ((par
                                      ((par ((sument ((prodent (primero (primero mat1))) (primero (primero mat1))))
                                                     ((prodent (segundo (primero mat1))) (primero (segundo mat1)))))
                                            ((sument ((prodent (primero (primero mat1))) (segundo (primero mat1))))
                                                     ((prodent (segundo (primero mat1))) (segundo (segundo mat1))))))
                                      ((par ((sument ((prodent (primero (segundo mat1))) (primero (primero mat1))))
                                                     ((prodent (segundo (segundo mat1))) (primero (segundo mat1)))))
                                            ((sument ((prodent (primero (segundo mat1))) (segundo (primero mat1))))
                                                     ((prodent (segundo (segundo mat1))) (segundo (segundo mat1))))))
                                   ))

;Determinante
(define determinante_m (lambda (matriz)
                             ((restaent ((prodent (primero (primero matriz))) (segundo (segundo matriz))))
                                        ((prodent (primero (segundo matriz))) (segundo (primero matriz))))))

(define determinante_p (lambda (matriz)
                          (lambda (num)
                            ((restoent (determinante_m matriz))num))))

;Adjunta
(define adjuntaMatriz (lambda (m)
                        ((par
                          ((par (segundo (segundo m))) ((restaent cero) (segundo (primero m)))))
                          ((par ((restaent cero) (primero (segundo m)))) (primero (primero m))))))


;Determinante Adjunta
(define determinantePorAdjunta (lambda (m)
                                (lambda (d)
                                  ((par
                                    ((par ((prodent (primero (primero m))) d))
                                          ((prodent (segundo (primero m))) d)))
                                    ((par ((prodent (primero (segundo m))) d)) 
                                          ((prodent (segundo (segundo m))) d))))))

;Inversa
(define inversa_m? (lambda (m) 
                           (noesceroent (determinanteMatriz m))))

(define inversa (lambda (m)
                             (lambda (num)
                             ((determinantePorAdjunta (adjuntaMatriz m)) (((inverso_p cero) (determinante_p m))num)))))

;Rango
(define rango_matriz_cero (lambda (m)
  (if (esceroent (primero (primero m))) (if (esceroent (segundo (primero m))) (if (esceroent (primero (segundo m))) (if (esceroent (segundo (segundo m))) true false) false) false) false)))

(define rango_matriz (lambda (m)
                      (if (rango_matriz_cero m) cero (if (esceroent(determinante_p m)) uno dos))))

;Potencias
(define multiplicacionMatricesModular (lambda (mat1)
                                        (lambda (mat2)
                                          (lambda (mod)
                                            ((par
                                              ((par ((sument (((prod_p (primero (primero mat1))) (primero (primero mat2)))mod))
                                                             (((prod_p (segundo (primero mat1))) (primero (segundo mat2)))mod)))
                                                    ((sument (((prod_p (primero (primero mat1))) (segundo (primero mat2)))mod))
                                                             (((prod_p (segundo (primero mat1))) (segundo (segundo mat2)))mod))))
                                              ((par ((sument (((prod_p (primero (segundo mat1))) (primero (primero mat2)))mod))
                                                             (((prod_p (segundo (segundo mat1))) (primero (segundo mat2)))mod)))
                                                    ((sument (((prod_p (primero (segundo mat1))) (segundo (primero mat2)))mod))
                                                             (((prod_p (segundo (segundo mat1))) (segundo (segundo mat2)))mod))))))))


(define potencia_matrices(lambda (m)
                           (lambda (e)
                             (lambda (mod)
                               (((Y (lambda (f)
                                      (lambda (matriz)
                                        (lambda(expo)
                                          ((((esigualnat expo)un)  
                                            (lambda (no_use)
                                              matriz
                                              ) 
                                            (lambda (no_use)
                                              (((par? expo)
                                                (lambda (no_use2)
                                                  ((f (((multiplicacionMatricesModular matriz)matriz)mod)) ((cocientenat expo)deux))
                                                  )
                                                (lambda (no_use2)
                                                  (((multiplicacionMatricesModular matriz) ((f matriz) ((restanat expo)un)))mod)
                                                  )
                                                )
                                               zero) 
                                              )
                                            )
                                           zero)    ; Pasa zero como argumento de no_use
                                          )
                                        )
                                      )
                                    )
                                 m) 
                                e)
                               )
                             )
                           )
 )


;Pruebas Matrices
;(testmatrices ((sumaMatrices matrizPrueba1)matrizPrueba2))
;((16 6) (1 8))

;(testmatrices ((multiplicacionMatrices matrizPrueba1)matrizPrueba2))
;((23 42) (9 13))

;(testmatrices (((multiplicacionMatricesModular matrizPrueba1)matrizPrueba2)cinco))
;((3 2) (4 3))

;(testenteros (determinante_m matriz_prueba3))
;7

;(testenteros((determinante_p matriz_prueba1) tres))
;2

;(testmatrices (adjuntaMatriz matrizPrueba4))
;((4 3) (0 1))

;(testmatrices ((determinantePorAdjunta matrizPrueba8)(((hacerInversoEnteros cero) (determinanteMatriz matrizPrueba8))cinco))
;((3 6) (3 12))

;(inversa? matrizPrueba1)
;true

;(testmatrices ((inversa matrizPrueba2)tres))
;((6 -4) (-4 2))

;(testenteros (rango_matriz matriz_prueba2))
;2

;(testmatrices (((potencia_matrices matrizPrueba8)diez)dos))
;((3 10) (5 18))


;_________________________________________________________________________________________________________________________________
;Matrices Ejemplo
(define identidad ((((matriz uno) cero) cero) uno))

(define matriz_nula ((((matriz cero) cero) cero) cero))

(define matriz_prueba1 ((((matriz dos) cuatro) -uno) cinco))

(define matriz_prueba2 ((((matriz uno) dos) dos) tres))

(define matriz_prueba3 ((((matriz dos) uno) -tres) dos))

(define matriz_prueba4 ((((matriz uno) -tres) cero) cuatro))

(define matrizPrueba8 ((((matriz uno) dos) uno) cuatro))
