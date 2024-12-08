package com.cosaverde.controller;

import com.cosaverde.domain.FAQ;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import java.util.ArrayList;

@Controller
public class FAQController {

    @GetMapping("/faq")
    public String getFAQ(Model model) {
        model.addAttribute("questions", getFAQList());
        return "faq"; // Nombre de la vista faq.html
    }

    private List<FAQ> getFAQList() {
        // Añadimos más preguntas frecuentes
        List<FAQ> faqList = new ArrayList<>();
        faqList.add(new FAQ("¿Cómo puedo crear una cuenta?", "Puedes crear una cuenta haciendo clic en el botón 'Registrarse' en la página principal."));
        faqList.add(new FAQ("¿Cómo restablezco mi contraseña?", "Para restablecer tu contraseña, haz clic en 'Olvidé mi contraseña' en la página de inicio de sesión."));
        faqList.add(new FAQ("¿Puedo cambiar el correo electrónico asociado a mi cuenta?", "Sí, puedes cambiar tu correo electrónico desde la sección 'Configuración' de tu cuenta."));
        faqList.add(new FAQ("¿Cómo puedo contactar con soporte?", "Puedes ponerte en contacto con nuestro soporte técnico a través del correo soporte@cosaverde.com o llamando al 123-456-789."));
        faqList.add(new FAQ("¿Puedo eliminar mi cuenta?", "Sí, puedes eliminar tu cuenta desde la sección de configuración de tu perfil."));
        return faqList;
    }
}
